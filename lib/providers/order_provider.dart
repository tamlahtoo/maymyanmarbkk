import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier{
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;


  getOrders() async {
    _orders = [];
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(baseUrl +
          "orders?token=$token"),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print('shi');
      print(token);
      ///check the status
      if (data['status'] == 'success') {
        List newCartData = data['orders']['data'];
        print(newCartData.toString());
        print('boo');
        _orders = List<OrderModel>.from(
            newCartData.map((model) => OrderModel.fromJson(model)));
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: "${data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      return false;
      throw Exception('Failed to Login');
    }
  }
}