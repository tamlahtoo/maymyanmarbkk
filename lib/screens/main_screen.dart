import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/screens/auth/profile_page.dart';
import 'package:maymyanmar/screens/exchange/exchange_page.dart';
import 'package:maymyanmar/screens/home/home_page.dart';
import 'package:maymyanmar/screens/news/news_page.dart';
import 'package:maymyanmar/screens/oder/order_page.dart';
import 'package:maymyanmar/screens/search/search_page.dart';
import 'package:maymyanmar/services/home_service.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:maymyanmar/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  late FirebaseMessaging messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      OrderPage(),
      ExchangePage(),
      NewsPage(),
      ProfilePage()
      // Center(
      //     child: TextButton(
      //   child: Text('logout'),
      //   onPressed: () {
      //     context.read<AuthProvider>().signOut();
      //   },
      // ))
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List bottomItems = [
      CupertinoIcons.home,
      CupertinoIcons.bag_fill,
      CupertinoIcons.money_dollar_circle,
      CupertinoIcons.news_solid,
      CupertinoIcons.profile_circled,
    ];
    List textItems = ["Home", "Orders", "Exchange","News", "Account"];
    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top:
                  BorderSide(width: 2, color: Colors.black.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      bottomItems[index],
                      // size: 22,
                      color: pageIndex == index ? pink : Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    pageIndex == index
                        ? Text(
                            textItems[index],
                            style: TextStyle(
                                fontSize: 12,
                                color: pageIndex == index
                                    ? pink
                                    : Colors.black.withOpacity(0.5)),
                          )
                        : Container()
                  ],
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
