import 'package:flutter/material.dart';
import 'package:maymyanmar/models/banner_model.dart';
import 'package:maymyanmar/models/category_model.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/services/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier{
  List<Category> _categories =[];
  List<Category> _categoryonly =[];
  List<Category> _brandOnly =[];
  List<Product> _products = [];
  int pageNumber = 0;
  bool _isLoadMore = true;
  List<BannerEntity> _bannerList = [];
  List<Product> _categorizedProduct = [];
  int _catPageNumber = 0;
  bool _isCatLoadMore = true;

  List<Category> get categories => _categories;
  List<Category> get categoryonly => _categoryonly;
  List<Category> get brandOnly => _brandOnly;
  List<Product> get products => _products;
  bool get isLoadMore => _isLoadMore;
  List<BannerEntity> get bannerList => _bannerList;
  List<Product> get categorizedProduct => _categorizedProduct;
  int get catPageNumber => _catPageNumber;
  bool get isCatLoadMore => _isCatLoadMore;

  getBanner() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print('$token');
    var bannerData = await getBannerService(token!);
    _bannerList = List<BannerEntity>.from(bannerData.map((model)=> BannerEntity.fromJson(model)));
    print(_bannerList);
    notifyListeners();
  }

  getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    pageNumber+=1;
    var data = await getProductsService(token!,pageNumber);
    List newProductData= data['products']['data'];
    var newProductList = List<Product>.from(newProductData.map((model)=> Product.fromJson(model)));
    _products = _products+newProductList;
    if(data['products']['last_page']==data['products']['current_page']){
      _isLoadMore = false;
    }
    notifyListeners();
  }

  clearCategorizedProducts() {
    _categorizedProduct = [];
    _catPageNumber = 0;
    _isCatLoadMore = true;
  }

  getCategorizedProducts(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    _catPageNumber+=1;
    var data = await getCatProductsService(token!,_catPageNumber,id);
    List newProductData= data['products']['data'];
    var newProductList = List<Product>.from(newProductData.map((model)=> Product.fromJson(model)));
    _categorizedProduct = _categorizedProduct+newProductList;
    print('bpp');
    print(newProductData);
    if(data['products']['last_page']==data['products']['current_page']){
      _isCatLoadMore = false;
    }
    notifyListeners();
  }

  getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    _categories = await getCategoriesService(token!,'');
    notifyListeners();
  }

  getBrands() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    _categoryonly = await getCategoriesService(token!,'category');
    _brandOnly = await getCategoriesService(token!,'brand');
    notifyListeners();
  }

}