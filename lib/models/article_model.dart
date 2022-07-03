// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Article {
  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
    required this.typeId,
    this.thumbnail,
    required this.views,
    required this.image,
    required this.status,
    required this.country,
  });

  int id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  String author;
  int typeId;
  dynamic thumbnail;
  int views;
  String image;
  int status;
  String country;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    author: json["author"],
    typeId: json["type_id"],
    thumbnail: json["thumbnail"],
    views: json["views"],
    image: json["image"],
    status: json["status"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "author": author,
    "type_id": typeId,
    "thumbnail": thumbnail,
    "views": views,
    "image": image,
    "status": status,
    "country": country,
  };
}
