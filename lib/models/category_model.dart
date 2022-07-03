class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    this.display_flag,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String image;
  dynamic display_flag;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    display_flag: json["display_flag"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "display_flag": display_flag,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
