import 'dart:convert';

class ExchangeRate {
  ExchangeRate({
    required this.id,
    required this.method_description,
    required this.thb,
    required this.createdAt,
    required this.updatedAt,
    required this.mmk,
    required this.special_offer,
  });

  int id;
  String method_description;
  String thb;
  DateTime createdAt;
  DateTime updatedAt;
  String mmk;
  int special_offer;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
    id: json["id"],
    method_description: json["method_description"],
    thb: json["thb"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    mmk: json["mmk"],
    special_offer: json["special_offer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_description": method_description,
    "thb": thb,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "mmk": mmk,
    "special_offer": special_offer,
  };
}
