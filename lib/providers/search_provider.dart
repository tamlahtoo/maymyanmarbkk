import 'package:flutter/material.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/services/search_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider with ChangeNotifier{
  List<Product> _searchedProducts = [];

  List<Product> get searchedProducts => _searchedProducts;


  searchProducts(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    _searchedProducts = await searchProductService(token!,keyword);
    print(_searchedProducts);
    notifyListeners();
  }

}