import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/models/exchange_model.dart';
import 'package:maymyanmar/providers/exchange_provider.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class ExchangePage extends StatefulWidget {
  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExchangeProvider>(context, listen: false).getExchangeRate();
  }

  Future<void> _pullRefresh() async {
    await Provider.of<ExchangeProvider>(context, listen: false).getExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<ExchangeRate> exchangeRates =
        context.watch<ExchangeProvider>().exchangeRates;
    List<ExchangeRate> specialExchangeRates =
        context.watch<ExchangeProvider>().spcialExchangeRates;
    List<ExchangeRate> kyatToBaht =
        context.watch<ExchangeProvider>().kyat_to_baht;
    String time = context.watch<ExchangeProvider>().time;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: pink,
          title: Text(
            'Today Exchange Rate',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bgColor,
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(
            children: [
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   child: Center(
              //     child: Text(
              //       'Today Exchange Rate',
              //       style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    '$time',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Methods',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Exchange Rate',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: <Widget>[
                    ...exchangeRates.map((item) {
                      return Container(
                        // height: 50,
                        // width: width / 2.3,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // height: 50,
                              width: width / 2.3,
                              child: Text("${item.method_description}"),
                            ),
                            Container(
                              // height: 50,
                              // width: width / 2.3,
                              child: Text("${item.thb}-${item.mmk}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Special Offer',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.yellow,
                      height: 2,
                    )),
                    Text(
                      'Above 5 Lakhs',
                      style: TextStyle(fontSize: 14),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.yellow,
                      height: 2,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Methods',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Exchange Rate',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: <Widget>[
                    ...specialExchangeRates.map((item) {
                      return Container(
                        // height: 50,
                        // width: width / 2.3,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // height: 50,
                              width: width / 2.3,
                              child: Text("${item.method_description}"),
                            ),
                            Container(
                              // height: 50,
                              // width: width / 2.3,
                              child: Text("${item.thb}-${item.mmk}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    // color: Colors.red,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Kyat to Baht',
                        style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Methods',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Exchange Rate',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: <Widget>[
                    ...kyatToBaht.map((item) {
                      return Container(
                        // height: 50,
                        // width: width / 2.3,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // height: 50,
                              width: width / 2.3,
                              child: Text("${item.method_description}"),
                            ),
                            Container(
                              // height: 50,
                              // width: width / 2.3,
                              child: Text("${item.thb}-${item.mmk}"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
