import 'package:flutter/cupertino.dart';
import 'package:maymyanmar/models/article_model.dart';
import 'package:maymyanmar/services/article_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider with ChangeNotifier{
  int pageNumber = 0;
  List<Article> _articles = [];
  bool _isLoadMore = true;

  List<Article> get articles => _articles;
  bool get isLoadMore => _isLoadMore;


  getArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print(token);
    pageNumber+=1;
    var data = await getArticleService(token!,pageNumber);
    List newArticleData= data['articles']['data'];
    var newArticleList = List<Article>.from(newArticleData.map((model)=> Article.fromJson(model)));
    _articles = _articles+newArticleList;
    if(data['articles']['last_page']==data['articles']['current_page']){
      _isLoadMore = false;
    }
    notifyListeners();
  }
}