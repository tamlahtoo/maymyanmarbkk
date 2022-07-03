import 'package:flutter/material.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/cart_provider.dart';
import 'package:maymyanmar/screens/auth/profile_edit_page.dart';
import 'package:maymyanmar/screens/cart/payment_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';


class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var items = [
    'J&T Express',
    'Grab Express',
  ];
  String dropdownvalue = 'J&T Express';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeliCost();
  }

  getDeliCost()async{
    if(dropdownvalue=='J&T Express'){
      await Provider.of<CartProvider>(context, listen: false).calculateDelivery(0);
    }else{
      await Provider.of<CartProvider>(context, listen: false).calculateDelivery(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String finalCost = context.watch<CartProvider>().finalCost;
    String deliCost = context.watch<CartProvider>().deliveyCost;
    User currentUser = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        title: Text('Check Out'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 20,),
          currentUser.country=='th'?Row(
            children: [
              Text('Delivey Method'),
              Expanded(child: Container()),
              DropdownButton(

                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    getDeliCost();
                  });
                },
              ),

            ],
          ):Row(
            children: [
              Text('Delivey Method'),
              Expanded(child: Container()),
              Text('Royal Express'),
            ],
          ),
          SizedBox(height: 50,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container(),),
                    GestureDetector(child: Text('Edit',style: TextStyle(color: Colors.blue),),onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileEditPage(user: currentUser,)),
                      );
                    },),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Address'),
                    Expanded(child: Container()),
                    Container(width:150,child: Text('${currentUser.address}',maxLines: 3,))
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Email'),
                    Expanded(child: Container()),
                    Container(width:150,child: Text('${currentUser.email}',maxLines: 3,))
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Phone number'),
                    Expanded(child: Container()),
                    Container(width:150,child: Text('${currentUser.phoneNumber}',maxLines: 3,))
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 70,
        child: Row(
          children: [
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Shipping: ',style: TextStyle(fontSize: 12),),
                    Container(width:150,child: Text('$deliCost ',style: TextStyle(color: Colors.green,fontSize: 12),)),
                  ],
                ),
                currentUser.country=='th'?Container():Text('ပစ္စည်းရောက်မှ ပို့ခ ပေးချေရန်',style: TextStyle(color: Colors.green,fontSize: 12),),
                Row(
                  children: [
                    Text('Total: ',style: TextStyle(fontSize: 18),),
                    Text('$finalCost ',style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
            Expanded(child: Container()),
            Container(
              height: 50,
              child: TextButton(
                onPressed: () async {
                  // await Provider.of<CartProvider>(context, listen: false).updateCart();
                  if(currentUser.country=='th'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage(deliveryMethod: dropdownvalue=="J&T Express"?0:1,)),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage(deliveryMethod: 2,)),
                    );
                  }

                },
                child: Text('   Payment   ',style: TextStyle(color: white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(pink),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}
