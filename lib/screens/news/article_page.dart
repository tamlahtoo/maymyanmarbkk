import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maymyanmar/models/article_model.dart';

class ArticlePage extends StatefulWidget {
  final Article articleModel;

  const ArticlePage({Key? key, required this.articleModel}) : super(key: key);
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
                Image.network(
                    "https://api.maymyanmar-bbk.com/uploads/${widget.articleModel.image}"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.articleModel.title}',
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${DateFormat('yyyy-MM-dd – hh:mm a').format(widget.articleModel.createdAt)}',
                        style: TextStyle( fontSize: 14,color: Colors.grey),maxLines: 3,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${widget.articleModel.content}',
                        style: TextStyle(fontSize: 16,),
                      ),

                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                width: 45,
                height: 45,
                child: Icon(Icons.arrow_back, size: 20,),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.6),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
