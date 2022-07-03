class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.stripeId,
    this.likedFood,
    this.likedRestaurants,
    required this.country,
    this.address,
    this.city,
    this.postalCode,
    this.phoneNumber,
    required this.deliveryCostGrab,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  var createdAt;
  var updatedAt;
  dynamic stripeId;
  dynamic likedFood;
  dynamic likedRestaurants;
  String country;
  dynamic address;
  dynamic city;
  dynamic postalCode;
  dynamic phoneNumber;
  int deliveryCostGrab;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"]??1,
    name: json["name"]??'',
    email: json["email"]??'',
    emailVerifiedAt: json["email_verified_at"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stripeId: json["stripeId"],
    likedFood: json["likedFood"],
    likedRestaurants: json["likedRestaurants"],
    country: json["country"],
    address: json["address"],
    city: json["city"],
    postalCode: json["postal_code"],
    phoneNumber: json["phone_number"],
    deliveryCostGrab: json["delivery_cost_grab"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "stripeId": stripeId,
    "likedFood": likedFood,
    "likedRestaurants": likedRestaurants,
    "country": country,
    "address": address,
    "city": city,
    "postal_code": postalCode,
    "phone_number": phoneNumber,
    "delivery_cost_grab": deliveryCostGrab,
  };
}
