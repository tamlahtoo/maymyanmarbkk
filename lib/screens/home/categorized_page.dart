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

class CategorizedPage extends StatefulWidget {
  final int id;
  final String name;

  const CategorizedPage({Key? key, required this.id, required this.name})
      : super(key: key);
  @override
  _CategorizedPageState createState() => _CategorizedPageState();
}

class _CategorizedPageState extends State<CategorizedPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .clearCategorizedProducts();
    Provider.of<HomeProvider>(context, listen: false)
        .getCategorizedProducts(widget.id);
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> catProducts =
        context.watch<HomeProvider>().categorizedProduct;
    User currentUser = context.read<AuthProvider>().currentUser;
    return SafeArea(
      child: WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop();
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            // preferredSize: Size.fromHeight(55),
            leadingWidth: 30,
            backgroundColor: pink,
            centerTitle: true,
            title: Text('${widget.name}'),
          ),
          body: ListView.builder(
            controller: _controller,
            itemCount: catProducts.length,
            addAutomaticKeepAlives: true,
            cacheExtent: double.infinity,
            itemBuilder: (context, index) {
              return buildProducts(catProducts[index], currentUser);
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildProducts(Product product, User currentUser) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                    productModel: product,
                  )),
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
                      "https://api.maymyanmar-bbk.com/uploads/${product.image}"),
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
                        bottomRight: Radius.circular(10)),
                    color: white),
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    // SizedBox(height: 10,),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      '${product.price} ${currentUser.country == 'th' ? 'THB' : 'Ks'}',
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

  void loadMore() async {
    print('try to load');
    bool _isLoadMore = context.read<HomeProvider>().isCatLoadMore;
    print(_isLoadMore);
    if (_isLoadMore) {
      print('loading');
      Provider.of<HomeProvider>(context, listen: false)
          .getCategorizedProducts(widget.id);
    }
  }
}
