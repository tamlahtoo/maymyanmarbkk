import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/providers/search_provider.dart';
import 'package:maymyanmar/screens/product_detail/product_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> searchList = context.watch<SearchProvider>().searchedProducts;
    User currentUser = context.read<AuthProvider>().currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // preferredSize: Size.fromHeight(55),
          leadingWidth: 30,
          backgroundColor: pink,
          title: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 15),
                hintText: 'Search products',
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
              onSubmitted: (val) {
                Provider.of<SearchProvider>(context, listen: false).searchProducts(val);
              },
            ),
          ),
        ),
        body: ListView.builder(
          controller: _controller,
          itemCount: searchList.length,
          addAutomaticKeepAlives: true,
          cacheExtent: double.infinity,
          itemBuilder: (context, index) {
            return buildProducts(searchList[index],currentUser);
          },
        ),
      ),
    );
  }

  GestureDetector buildProducts(Product product,User currentUser) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(productModel: product,)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 130,
                  image: NetworkImage(
                      "http://3.137.111.216/uploads/${product.image}"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: white),
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '${product.price} ${currentUser.country=='th'?'THB':'Ks'}',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
