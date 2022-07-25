import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/services/cart_service.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget {
  final Product productModel;

  const ProductPage({Key? key, required this.productModel}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    User currentUser = context.read<AuthProvider>().currentUser;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
                CachedNetworkImage(imageUrl: "https://api.maymyanmar-bbk.com/uploads/${widget.productModel.image}"),
                // Image.network(
                //     "https://api.maymyanmar-bbk.com/uploads/${widget.productModel.image}"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.productModel.name}',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.productModel.price} ${currentUser.country=='th'?'THB':'Ks'}',
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Availibility',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.productModel.inventoryQuantity==0?"Sold Out":'In stock',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${widget.productModel.description}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            '${widget.productModel.weight} Kg',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            '${widget.productModel.inventoryQuantity}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                width: 45,
                height: 45,
                child: Icon(Icons.arrow_back, size: 20,),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.6),),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: GestureDetector(
          onTap: ()async{
            print("hi");
            await addCart(widget.productModel.id,1);
          },
          child: Container(
              decoration: BoxDecoration(
                color: pink,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add to Cart',
                    style: TextStyle(color: white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    CupertinoIcons.cart_fill_badge_plus,
                    color: white,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
