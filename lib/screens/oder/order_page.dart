import 'package:flutter/material.dart';
import 'package:maymyanmar/models/order_model.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/order_provider.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getOrders();
  }

  Future<void> _pullRefresh() async {
    await Provider.of<OrderProvider>(context, listen: false).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = context.watch<OrderProvider>().orders;
    User currentUser = context.read<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        title: Text('Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          itemCount: orders.length,
          addAutomaticKeepAlives: true,
          cacheExtent: double.infinity,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              child: Column(
                children: [
                  PendingStatus(
                    pending_status: orders[index].pending_status,
                  ),
                  Column(
                    children: <Widget>[
                      ...orders[index].order_items.map((item) {
                        return Container(
                            // height: 50,
                            // width: width / 2.3,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                // border: Border(
                                //   top: BorderSide(width: 1.0, color: Colors.grey),
                                // ),
                                ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    width: MediaQuery.of(context).size.width / 3,
                                    height: 70,
                                    image: NetworkImage(
                                        "http://3.137.111.216/uploads/${item.product_image}"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${item.product_name}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Quanity: ${item.product_quantity}'),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
                                  '${item.product_price}${currentUser.country == 'th' ? 'THB' : 'Ks'}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ));
                      }).toList(),
                    ],
                  ),
                  Container(height: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Text('Delivery Price:       '),
                      Text(
                        '${orders[index].delivery_cost}${currentUser.country == 'th' ? 'THB' : 'Ks'}',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Text('Total Price:       '),
                      Text(
                        '${orders[index].total_price}${currentUser.country == 'th' ? 'THB' : 'Ks'}',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                  // Text('${orders[index].order_items[0].product_name}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void loadMore() async {
    // print('try to load');
    // bool _isLoadMore = context.read<HomeProvider>().isCatLoadMore;
    // print(_isLoadMore);
    // if (_isLoadMore) {
    //   print('loading');
    //   Provider.of<HomeProvider>(context, listen: false).getCategorizedProducts(widget.id);
    // }
  }
}

class PendingStatus extends StatelessWidget {
  final pending_status;

  const PendingStatus({Key? key, this.pending_status}) : super(key: key);
  Widget build(BuildContext context) {
    if (pending_status == 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.orange),
        child: Text(
          'Pending',
          style: TextStyle(color: Colors.white),
        ),
      );
    }else if(pending_status==1){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.orange),
        child: Text(
          'Process',
          style: TextStyle(color: Colors.white),
        ),
      );
    }else if(pending_status==2){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.red),
        child: Text(
          'Rejected',
          style: TextStyle(color: Colors.white),
        ),
      );
    }else if(pending_status==3){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Text(
          'Approved',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.orange),
      child: Text(
        'Pending',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
