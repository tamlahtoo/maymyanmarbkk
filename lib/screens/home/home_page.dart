import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/banner_model.dart';
import 'package:maymyanmar/models/category_model.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/screens/cart/cart_page.dart';
import 'package:maymyanmar/screens/home/brand_page.dart';
import 'package:maymyanmar/screens/home/categorized_page.dart';
import 'package:maymyanmar/screens/product_detail/product_page.dart';
import 'package:maymyanmar/screens/search/search_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:maymyanmar/theme/styles.dart';
import 'package:maymyanmar/widgets/custom_slider.dart';
import 'package:maymyanmar/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getCategories();
    Provider.of<HomeProvider>(context, listen: false).getProducts();
    Provider.of<HomeProvider>(context, listen: false).getBanner();
    // Setup the listener.
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

  Future<void> _pullRefresh() async {
    Provider.of<HomeProvider>(context, listen: false).pageNumber = 0;
    await Provider.of<HomeProvider>(context, listen: false).getCategories();
    await Provider.of<HomeProvider>(context, listen: false).getProducts();
    await Provider.of<HomeProvider>(context, listen: false).getBanner();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    List<Category> categoryList = context.watch<HomeProvider>().categories;
    List<Product> productList = context.watch<HomeProvider>().products;
    List<BannerEntity> bannerList = context.watch<HomeProvider>().bannerList;
    User currentUser = context.read<AuthProvider>().currentUser;
    // bool _isLoadMore = context.watch<HomeProvider>().isLoadMore;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: pink,
          title: Text(
            'May Myannmar',
            style: TextStyle(color: white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Container(
                width: 30,
                child: Icon(
                  CupertinoIcons.search,
                  color: white,
                  size: 26,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Container(
                width: 40,
                child: Icon(
                  CupertinoIcons.shopping_cart,
                  color: white,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.separated(
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            controller: _controller,
            itemCount: productList.length + 1,
            addAutomaticKeepAlives: true,
            cacheExtent: double.infinity,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildBanner(bannerList);
              }
              return buildProducts(productList[index - 1], currentUser);
            },
            separatorBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return buildCategory(categoryList);
              }
              return Container();
            }, //nth item as ads.
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
                child: CachedNetworkImage(
                  imageUrl: "https://api.maymyanmar-bbk.com/uploads/${product.image}",
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 130,
                  fit: BoxFit.fitHeight,
                ),
                // child: Image(
                //   width: MediaQuery.of(context).size.width / 2.5,
                //   height: 130,
                //   image: NetworkImage(
                //       "https://api.maymyanmar-bbk.com/uploads/${product.image}"),
                //   fit: BoxFit.fitHeight,
                // ),
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
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
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

  Container buildBanner(List<BannerEntity> bannerList) {
    if (bannerList.length == 3) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: CustomSliderWidget(
          items: [
            "https://api.maymyanmar-bbk.com/uploads/" + bannerList[0].image_name,
            "https://api.maymyanmar-bbk.com/uploads/" + bannerList[1].image_name,
            "https://api.maymyanmar-bbk.com/uploads/" + bannerList[2].image_name,
          ],
        ),
      );
    }
    return Container(child: Text('Loading...'));
  }

  Column buildCategory(List<Category> categoryList) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(margin:EdgeInsets.only(left:15,top: 10 ),child: Text('Category',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
            GestureDetector(
              child: Container(margin:EdgeInsets.only(right:10 ,top: 10),child: Text('See All',style: TextStyle(fontSize: 16,color: Colors.pink),)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrandPage()
                  ),
                );
              },
            ),
          ],
        ),
        Container(
          height: 160,
          // margin: EdgeInsets.symmetric( vertical: 10),
          child: ListView.builder(
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20, bottom: 5, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategorizedPage(
                              id: categoryList[index].id,
                              name: categoryList[index].name,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: CachedNetworkImage(
                            imageUrl: "https://api.maymyanmar-bbk.com/uploads/${categoryList[index].image}",
                            fit: BoxFit.cover,
                          ),
                          // child: Image(
                          //   image: NetworkImage(
                          //       "https://api.maymyanmar-bbk.com/uploads/${categoryList[index].image}"),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 80,
                      child: Text(
                        '${categoryList[index].name}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void loadMore() async {
    print('try to load');
    bool _isLoadMore = context.read<HomeProvider>().isLoadMore;
    print(_isLoadMore);
    if (_isLoadMore) {
      print('loading');
      Provider.of<HomeProvider>(context, listen: false).getProducts();
    }
  }
}
