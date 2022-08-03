import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/product_model.dart';


searchProductService(String token, String keyword) async {
  final response = await http.get(Uri.parse(baseUrl + "products/search?token=$token&product_name=$keyword"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      List productList = data['products']['data'];
      List<Product> products = List<Product>.from(productList.map((model)=> Product.fromJson(model)));
      return products;
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
    List<Product> products = [];
    return products;
    throw Exception('Failed to Login');
  }
}