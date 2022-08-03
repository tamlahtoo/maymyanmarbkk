import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maymyanmar/main.dart';
import 'package:maymyanmar/providers/cart_provider.dart';
import 'package:maymyanmar/providers/order_provider.dart';
import 'package:maymyanmar/screens/main_screen.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final int deliveryMethod;

  const PaymentPage({Key? key, required this.deliveryMethod}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var items = [
    'Cash on Delivery',
    'Bank Payment',
  ];
  String dropdownvalue = 'Bank Payment';
  File _image = File('');
  @override
  Widget build(BuildContext context) {
    String finalCost = context.watch<CartProvider>().finalCost;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 20,
          ),
          widget.deliveryMethod == 0
              ? Container()
              : Row(
                  children: [
                    Text('Payment Method'),
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
                          // getDeliCost();
                        });
                      },
                    ),
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          dropdownvalue == 'Cash on Delivery'
              ? Container()
              : Container(
                  height: 200,
                  child: _image.path == ''
                      ? GestureDetector(
                          onTap: () async {
                            _getImage();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              // height: 50,
                              // width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Container()),
                                  Icon(Icons.add_to_photos),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Upload Bank Slip',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(child: Container())
                                ],
                              )),
                        )
                      : Container(
                          child: GestureDetector(
                              onTap: () async {
                                _getImage();
                              },
                              child: Image.file(_image)),
                        ),
                ),
          // GestureDetector(
          //   child: Text('Upload'),
          //   onTap: ()async{
          //     await Provider.of<CartProvider>(context, listen: false).placeOrder(1,_image);
          //   },
          // )
          SizedBox(
            height: 10,
          ),
          dropdownvalue == 'Cash on Delivery'
              ? Container()
              : Column(
                  children: [
                    // Text('Send money to following account and upload the slip.',textAlign: TextAlign.center,),
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
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   Kpay/Wave',
                            style:
                            TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '09777284176',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Su Su Hlaing',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 10, vertical: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       // Icon(
                          //       //   Icons.send,
                          //       //   color: Colors.black87,
                          //       // ),
                          //       // SizedBox(
                          //       //   width: 15,
                          //       // ),
                          //       Text(
                          //         'Bank Name',
                          //         style: TextStyle(color: Colors.black54),
                          //       ),
                          //       Text(
                          //         'Aya Bank',
                          //         style: TextStyle(color: Colors.black87),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
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
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   Thailand',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Bank Account',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '0471189693',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Mr. Zaw Htwe',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Bank Name',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Kasikorn Bank',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '   Myanmar',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Bank Account',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  '20003423150',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Su Su Hlaing',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   Icons.send,
                                //   color: Colors.black87,
                                // ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                Text(
                                  'Bank Name',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Aya Bank',
                                  style: TextStyle(color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$finalCost',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            Expanded(child: Container()),
            Container(
              height: 50,
              child: TextButton(
                onPressed: () async {
                  if (dropdownvalue == 'Cash on Delivery') {
                    _image = File('');
                    await Provider.of<CartProvider>(context, listen: false)
                        .placeOrder(0, _image, widget.deliveryMethod);
                    await Provider.of<OrderProvider>(context, listen: false)
                        .getOrders();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
                  } else if (dropdownvalue == 'Bank Payment' &&
                      _image.path != '') {
                    await Provider.of<CartProvider>(context, listen: false)
                        .placeOrder(1, _image, widget.deliveryMethod);
                    await Provider.of<OrderProvider>(context, listen: false)
                        .getOrders();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
                  }
                },
                child: Text(
                  '   Place Order   ',
                  style: TextStyle(color: white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(pink),
                  shadowColor: MaterialStateProperty.all<Color>(black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  _getImage() async {
    print('hi');
    // ImageP
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    _image = File(image!.path);
    setState(() {});
  }
}
