import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maymyanmar/constants/url.dart';

getArticleService(String token,int pageNumber) async {
  final response = await http.get(Uri.parse(baseUrl + "articles?page=$pageNumber&token=$token"),);
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
