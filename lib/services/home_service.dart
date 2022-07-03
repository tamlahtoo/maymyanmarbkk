import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/category_model.dart';
import 'package:maymyanmar/models/product_model.dart';

getBannerService(String token) async {
  final response = await http.get(Uri.parse(baseUrl + "banner/images?token=$token"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      List bannerList = data['images'];
      return bannerList;
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

getProductsService(String token,int pageNumber) async {
  final response = await http.get(Uri.parse(baseUrl + "products?page=$pageNumber&token=$token"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      List productList = data['products']['data'];
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

getCatProductsService(String token,int pageNumber,int catID) async {
  final response = await http.get(Uri.parse(baseUrl + "categories/$catID?page=$pageNumber&token=$token"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      List productList = data['products']['data'];
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

getCategoriesService(String token) async {
  final response = await http.get(Uri.parse(baseUrl + "categories?token=$token"),);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      List categoryList = data['categories']['data'];
      List<Category> categories = List<Category>.from(categoryList.map((model)=> Category.fromJson(model)));
      print(categories[0].image);
      return categories;
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
    List<Category> categories = [];
    return categories;
    throw Exception('Failed to Login');
  }
}