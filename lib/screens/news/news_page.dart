import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maymyanmar/models/article_model.dart';
import 'package:maymyanmar/models/product_model.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/providers/news_provider.dart';
import 'package:maymyanmar/providers/search_provider.dart';
import 'package:maymyanmar/screens/news/article_page.dart';
import 'package:maymyanmar/screens/product_detail/product_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getArticles();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          loadMore();
        }
      }
    });
  }

  Future<void> _pullRefresh() async {
    await Provider.of<NewsProvider>(context, listen: false).getArticles();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> articles = context.watch<NewsProvider>().articles;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // preferredSize: Size.fromHeight(55),
          leadingWidth: 30,
          backgroundColor: pink,
          centerTitle: false,
          title: Text('News'),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView.builder(
            controller: _controller,
            itemCount: articles.length,
            addAutomaticKeepAlives: true,
            cacheExtent: double.infinity,
            itemBuilder: (context, index) {
              return buildArticle(articles[index]);
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildArticle(Article article) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticlePage(articleModel: article,)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight:  Radius.circular(10),topLeft: Radius.circular(10)),
                child: Image(
                  width: MediaQuery.of(context).size.width ,
                  image: NetworkImage(
                      "http://3.137.111.216/uploads/${article.image}"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  color: white),
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${article.title}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),maxLines: 3,
                      ),
                      Expanded(child: Container(),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '${DateFormat('yyyy-MM-dd – hh:mm a').format(article.createdAt)}',
                    style: TextStyle( fontSize: 14,color: Colors.grey),maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadMore() async {
    // print('try to load');
    // bool _isLoadMore = context.read<NewsProvider>().isLoadMore;
    // print(_isLoadMore);
    // if (_isLoadMore) {
    //   print('loading');
    //   Provider.of<NewsProvider>(context, listen: false).getArticles();
    // }
  }
}
