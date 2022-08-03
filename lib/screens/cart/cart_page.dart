import 'package:flutter/material.dart';
import 'package:maymyanmar/models/cart_model.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/cart_provider.dart';
import 'package:maymyanmar/screens/cart/checkout_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartMethod();
  }

  void cartMethod()async{
    await Provider.of<CartProvider>(context, listen: false).getCart();
    Provider.of<CartProvider>(context, listen: false).calculateTotalPrice();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItemList = context.watch<CartProvider>().cartItems;
    int totalPrice = context.watch<CartProvider>().totalPrice;
    User currentUser = context.read<AuthProvider>().currentUser;
    bool isLoading = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // preferredSize: Size.fromHeight(55),
          leadingWidth: 30,
          backgroundColor: pink,
          centerTitle: true,
          title: Text('My Cart'),
        ),
        body: ListView.builder(
          controller: _controller,
          itemCount: cartItemList.length,
          addAutomaticKeepAlives: true,
          cacheExtent: double.infinity,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Provider.of<CartProvider>(context, listen: false).deleteCartItem(cartItemList[index].id);
                    },
                    child: Icon(
                      Icons.delete
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 100,
                      image: NetworkImage(
                          "https://api.maymyanmar-bbk.com/uploads/${cartItemList[index].product_image}"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cartItemList[index].product_name}',
                          style: TextStyle(),
                        ),
                        Text(
                          '${cartItemList[index].product_price} ${currentUser.country=='th'?'THB':'Ks'}',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .changeQuantity(
                                        cartItemList[index].id, false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: Text('-',style: TextStyle(color: white),),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              // color: Colors.grey.withOpacity(0.3),
                              child: Center(
                                child: Text(
                                  '${cartItemList[index].quantity}',
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<CartProvider>(context, listen: false)
                                    .changeQuantity(cartItemList[index].id, true);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: Center(
                                  child: Text('+',style: TextStyle(color: white),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
          height: 80,
          child: Row(
            children: [
              Expanded(child: Container()),
              Text('Total: '),
              Text('$totalPrice ${currentUser.country=='th'?'THB':'Ks'}',style: TextStyle(color: Colors.green,fontSize: 18),),
              SizedBox(width: 10,),
              Container(
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {

                    });
                    showAlertDialog(context);
                    await Provider.of<CartProvider>(context, listen: false).updateCart();
                    Navigator.pop(dialogContext);
                    if(cartItemList.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
                    }
                  },
                  child: Text('   Check Out   ',style: TextStyle(color: white),),
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
      ),
    );
  }

  late BuildContext dialogContext;

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Call us"),
      content: Container(
        height: 100,
        child: Center(child: Text('Loading...')),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return alert;
      },
    );
  }
}
