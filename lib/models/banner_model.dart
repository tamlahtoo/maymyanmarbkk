class BannerEntity {
  BannerEntity(
      {required this.id,
      required this.image_name,
      required this.purpose,
      this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.country});

  int id;
  String image_name;
  String purpose;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  String country;

  factory BannerEntity.fromJson(Map<String, dynamic> json) => BannerEntity(
      id: json["id"],
      image_name: json["image_name"],
      purpose: json["purpose"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      country: json["country"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_name": image_name,
        "purpose": purpose,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "country": country
      };
}
