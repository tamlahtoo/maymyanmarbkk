import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maymyanmar/constants/url.dart';
import 'package:maymyanmar/models/exchange_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExchangeProvider with ChangeNotifier{
  List<ExchangeRate> _exchangeRates = [];
  List<ExchangeRate> _spcialExchangeRates = [];
  List<ExchangeRate> _kyat_to_baht = [];
  String _time = '';

  List<ExchangeRate> get exchangeRates => _exchangeRates;
  List<ExchangeRate> get spcialExchangeRates => _spcialExchangeRates;
  List<ExchangeRate> get kyat_to_baht => _kyat_to_baht;
  String get time => _time;


  getExchangeRate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.get(Uri.parse(baseUrl + "exchange-rate?token=$token"),);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      ///check the status
      if (data['status'] == 'success') {
        var exchangeData = data['exchange_rates'];
        var specialExchangeData = data['exchange_rates_special'];
        var kyatToBahtData = data['kyat_to_baht'];
        _time = data['time'];
        _exchangeRates = List<ExchangeRate>.from(exchangeData.map((model)=> ExchangeRate.fromJson(model)));
        _spcialExchangeRates = List<ExchangeRate>.from(specialExchangeData.map((model)=> ExchangeRate.fromJson(model)));
        _kyat_to_baht = List<ExchangeRate>.from(kyatToBahtData.map((model)=> ExchangeRate.fromJson(model)));
        notifyListeners();
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
}