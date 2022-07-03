import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/cart_model.dart';
import 'package:maymyanmar/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  int _totalPrice = 0;
  String _deliveryCost = "";
  String _finalCost = "";

  List<CartItem> get cartItems => _cartItems;
  int get totalPrice => _totalPrice;
  String get deliveyCost => _deliveryCost;
  String get finalCost => _finalCost;

  clearCartData()async{
    _cartItems = [];
    _totalPrice = 0;
    _deliveryCost = "";
    _finalCost = "";
    notifyListeners();
  }

  placeOrder(int paymentMethod, File _image,int delivery_method) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    String fileName = _image.path.split('/').last;
    Dio dio = Dio();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var response;
    if (_image.path == '') {
      response = await dio
          .post(baseUrl + "orders?token=$token&payment_method=$paymentMethod&delivery_method=$delivery_method");
    } else {
      FormData fd = FormData.fromMap({
        'payment_slip': await MultipartFile.fromFile(
          _image.path,
          filename: fileName,
        ),
      });
      try {
        response = await dio.post(
            baseUrl + "orders?token=$token&payment_method=$paymentMethod",
            data: fd);
      } catch (e) {
        if (e is DioError) {
          //handle DioError here by error type or by error code
          print('error');
          print(e);

        } else {}
        //return empty list (you can also return custom error to be handled by Future Builder)
      }
    }
    if (response.statusCode == 200) {
      var data = jsonDecode(response.toString());
      print(data);
      clearCartData();

      ///check the status
      if (data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "${data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  calculateDelivery(int deliMethod) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(baseUrl +
          "order/delivery-cost?token=$token&delivery_method=$deliMethod"),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);

      ///check the status
      if (data['status'] == 'success') {
        _finalCost = data['total_price'];
        _deliveryCost = data['delivery_cost'];
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

  getCart() async {
    _cartItems = [];
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print(token);
    var data = await getCartService(token!);
    List newCartData = data['cart']['cart_items'];
    _cartItems = List<CartItem>.from(
        newCartData.map((model) => CartItem.fromJson(model)));
    notifyListeners();
  }

  deleteCartItem(int itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse(baseUrl + "carts?token=$token&cart_item_id=$itemId"),
    );
    await getCart();
    await calculateTotalPrice();
  }

  updateCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    for (CartItem item in cartItems) {
      final response = await http.put(
        Uri.parse(baseUrl +
            "carts?token=$token&cart_item_id=${item.id}&quantity=${item.quantity}"),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);

        ///check the status
        if (data['status'] == 'success') {
          print('updated');
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

  changeQuantity(int id, bool isAdd) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    _totalPrice = 0;
    for (CartItem item in cartItems) {
      if (item.id == id) {
        if (isAdd) {
          item.quantity += 1;
        } else {
          if (item.quantity != 1) {
            item.quantity -= 1;
          }
        }
      }
      int pricee = item.quantity * item.product_price;
      _totalPrice += pricee;
      print('fff$pricee');
    }
    notifyListeners();
  }

  calculateTotalPrice() async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    _totalPrice = 0;
    for (CartItem item in cartItems) {
      int pricee = item.quantity * item.product_price;
      _totalPrice += pricee;
      print('fff$pricee');
    }
    print('fine');
    notifyListeners();
  }
}
