import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:maymyanmar/constants/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

addCart(int productID, int quantity) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final response = await http.post(Uri.parse(baseUrl + "carts?token=$token&product_id=$productID&quantity=$quantity"));
  print('productID$productID');
  if (response.statusCode == 200) {
    print("hi");
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      Fluttertoast.showToast(
          msg: "Item added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    } else if (data['status'] == 'fail') {
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
    print("girl${response.statusCode}");
    print("girl${response.body}");
    return false;
    throw Exception('Failed to Login');
  }
}

getCartService(String token) async {
  final response = await http.get(Uri.parse(baseUrl + "carts?token=$token"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      return data;
    } else if (data['status'] == 'fail') {
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

