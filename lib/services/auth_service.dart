import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:maymyanmar/constants/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

signinUser(String phone_number, String password) async {
  final response = await http.post(Uri.parse(baseUrl + "login"),
      body: {'phone_number': phone_number, 'password': password});
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token',data['userauth']['token']);
      await prefs.setInt('userID',data['userauth']['id']);
      final String? token = prefs.getString('token');
      print(token!+'goal');
      return true;
    } else if (data['status'] == 'fail') {
      Fluttertoast.showToast(
          msg: "${data['msg']}",
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

signupUser(
{required String country, username, phone_number, password}) async {
  final response = await http.post(Uri.parse(baseUrl + "register"), body: {
    'name': username,
    'phone_number': phone_number,
    'password': password,
    'confirm_password':password,
    'country': country
  });
  if (response.statusCode == 200) {
    print('yoee');
    var data = jsonDecode(response.body.toString());
    ///check the status
    if (data['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token',data['token']);
      await prefs.setInt('userID',data['userauth']['id']);
      final String? token = prefs.getString('token');
      print(token!+'goal');
      return true;
    } else if (data['status'] == 'fail') {
      Fluttertoast.showToast(
          msg: "${data['validation_message'][0]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } else {
    print('error');
    print(response.statusCode);
    return false;
    throw Exception('Failed to Login');
  }
}
