import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier{
  bool _isAuth = false;
  bool _showSignIn = true;
  bool _loading = true;
  User _currentUser = User(id: 0, name: '', email: '', country: 'th', deliveryCostGrab: 0);
  bool _verify = true;

  bool get isAuth => _isAuth;
  bool get showSignIn => _showSignIn;
  bool get loading => _loading;
  User get currentUser => _currentUser;
  bool get verify => _verify;

  checkSignin()async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if(token!=null){
      _isAuth = true;
      _loading = false;
      notifyListeners();
    }else{
      _loading = false;
      notifyListeners();
    }
  }

  checkVerification()async{
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(Uri.parse(baseUrl + "user/check-approve?token=$token"),);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      ///check the status
      if (data['status'] =="succes") {
        if(data['admin_approved']==1){
          _verify = true;
        }else{
          _verify = false;
        }
        notifyListeners();
      } else  {
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

  changeProfileInfo(String name,String email,String phoneNum,String address,String city,String postalCode)async{
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(Uri.parse(baseUrl + "user/update?name=$name&email=$email&address=$address&phone_number=$phoneNum&city=$city&postal_code=$postalCode&token=$token"),);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      getCurrentUser();
      ///check the status
      if (data['success'] ) {
        notifyListeners();
      } else  {
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

  getCurrentUser()async{
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(Uri.parse(baseUrl + "user?token=$token"),);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      ///check the status
      if (data['success'] ) {
        var userData = data['user'];
        _currentUser = User.fromJson(userData);
        notifyListeners();
      } else  {
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

  signIn(String phone,String password)async{
    _isAuth = await signinUser(phone,password)??false;
    notifyListeners();
  }

  signUp({required String country, username, phone, password})async{
    _isAuth = await signupUser(username: username,password: password,phone_number: phone,country: country)??false;
    notifyListeners();
  }

  signOut()async{
    print('hi');
    final prefs = await SharedPreferences.getInstance();
    final deleteToken = await prefs.remove('token');
    final deleteUserID = await prefs.remove('userID');
    _isAuth = false;
    notifyListeners();
  }

  toggle(bool isShow){
    _showSignIn = isShow;
    notifyListeners();
  }

}