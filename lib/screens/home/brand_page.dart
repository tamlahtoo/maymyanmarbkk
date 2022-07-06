import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/models/category_model.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/screens/home/categorized_page.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';

class BrandPage extends StatefulWidget {
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categoryOnlyList = context.watch<HomeProvider>().categoryonly;
    List<Category> brandOnlyList = context.watch<HomeProvider>().brandOnly;

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, color: Colors.white),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            backgroundColor: pink,
            bottom: const TabBar(
              labelPadding: EdgeInsets.only(bottom: 20),
              tabs: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Brands',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            // title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              buildBrandList(categoryOnlyList,context),
              buildBrandList(brandOnlyList,context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBrandList(List<Category> categoryList,BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: categoryList.length,
        addAutomaticKeepAlives: true,
        cacheExtent: double.infinity,
        itemBuilder: (context, index) {
          return GestureDetector(
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
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Image(
                        image: NetworkImage(
                            "http://3.137.111.216/uploads/${categoryList[index].image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('${categoryList[index].name}'),
                  // Text('${orders[index].order_items[0].product_name}'),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
