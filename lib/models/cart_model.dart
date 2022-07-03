class CartItem {
  CartItem({
    required this.id,
    required this.product_name,
    required this.product_image,
    required this.cart_id,
    required this.product_price,
    required this.product_id,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String product_name;
  String product_image;
  int cart_id;
  int product_price;
  int product_id;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    product_name: json["product_name"]??"",
    product_image: json["product_image"]??"",
    cart_id: json["cart_id"]??0,
    product_price: json["product_price"]??0,
    product_id: json["product_id"],
    quantity: json["quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": product_name,
    "product_image": product_image,
    "cart_id": cart_id,
    "product_price": product_price,
    "product_id": product_id,
    "quantity": quantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
