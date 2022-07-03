class OrderModel {
  OrderModel(
      {required this.id,
      required this.user_id,
      required this.total_price,
      required this.payment_id,
      required this.pending_status,
      required this.createdAt,
      required this.updatedAt,
      required this.delivery_cost,
      required this.order_items});

  int id;
  int user_id;
  int total_price;
  int payment_id;
  int pending_status;
  int delivery_cost;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItemModel> order_items;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        user_id: json["user_id"] ?? 0,
        total_price: json["total_price"] ?? 0,
        payment_id: json["payment_id"] ?? 0,
        pending_status: json["pending_status"] ?? 0,
        delivery_cost: json["delivery_cost"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        order_items: List<OrderItemModel>.from(json["order_items"].map((x) => OrderItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "total_price": total_price,
        "payment_id": payment_id,
        "pending_status": pending_status,
        "delivery_cost": delivery_cost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_items": order_items
      };
}

class OrderItemModel {
  OrderItemModel(
      {required this.id,
      required this.order_id,
      required this.product_id,
      required this.product_quantity,
      required this.product_price,
      required this.createdAt,
      required this.updatedAt,
      required this.product_name,
      required this.product_image});

  int id;
  int order_id;
  int product_id;
  int product_quantity;
  int product_price;
  String product_name;
  DateTime createdAt;
  DateTime updatedAt;
  String product_image;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
      id: json["id"],
      order_id: json["order_id"] ?? 0,
      product_id: json["product_id"] ?? 0,
      product_quantity: json["product_quantity"],
      product_price: json["product_price"],
      product_name: json["product_name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      product_image: json["product_image"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": order_id,
        "product_id": product_id,
        "product_quantity": product_quantity,
        "product_price": product_price,
        "product_name": product_name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_image": product_image
      };
}
