class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.image,
    required this.price,
    required this.featured,
    this.image1,
    this.image2,
    required this.productCategoryId,
    this.discountId,
    this.inventoryQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.profit,
    required this.weight,
    required this.discount_amount,
    required this.min_number_of_product_for_discount
  });

  int id;
  String name;
  String description;
  int rating;
  String image;
  int price;
  int featured;
  dynamic image1;
  dynamic image2;
  int productCategoryId;
  dynamic discountId;
  dynamic inventoryQuantity;
  DateTime createdAt;
  DateTime updatedAt;
  var weight;
  int profit;
  int discount_amount;
  int min_number_of_product_for_discount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"]??"",
    description: json["description"]??"",
    rating: json["rating"]??0,
    image: json["image"]??"",
    price: json["price"]??0,
    featured: json["featured"],
    image1: json["image1"],
    image2: json["image2"],
    productCategoryId: json["product_category_id"]??0,
    discountId: json["discount_id"],
    inventoryQuantity: json["inventory_quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    discount_amount: json['discount_amount']??0,
    min_number_of_product_for_discount: json['min_number_of_product_for_discount']??0,
    profit: json["profit"],
    weight: json['weight'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "rating": rating,
    "image": image,
    "price": price,
    "featured": featured,
    "image1": image1,
    "image2": image2,
    "product_category_id": productCategoryId,
    "discount_id": discountId,
    "inventory_quantity": inventoryQuantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "weight": weight,
    "profit": profit,
    "discount_amount": discount_amount,
    "min_number_of_product_for_discount":min_number_of_product_for_discount,
  };
}
