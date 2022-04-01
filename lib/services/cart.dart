import 'dart:convert';

import 'package:frontend/services/course.dart';
import 'package:http/http.dart';

class Cart {
  static const String endpoint = "http://10.0.2.2:8070/cart";
  final String cartId;
  final String courseId;
  final String status;
  final String? courseName;
  final String? courseImage;
  final String? coursePrice;

  const Cart({
    required this.cartId,
    required this.courseId,
    required this.status,
    this.courseName,
    this.courseImage,
    this.coursePrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    Cart cart = Cart(
        cartId: json['_id'],
        courseId: json['courseId'].toString(),
        status: json['status'],
        courseName: json['courseId']['courseName'],
        courseImage: json['courseId']['courseImage'],
        coursePrice: json['courseId']['coursePrice'].toString(),
        );
    return cart;
  }

  Map<String, dynamic> toJson() {
    return {"courseId": courseId, "status": status};
  }

  static Future<dynamic> addToCart(Cart cart) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(cart), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to add new user');
    }
  }

  static Future<bool> IsItemAdded(String id) async {
    Response response = await get(Uri.parse(endpoint + '/check/${id}'));
    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)["status"];
      return status;
    } else {
      throw Exception('Invalid process!!!');
    }
  }

    static Future<double> getCartTotal() async {
    Response response = await get(Uri.parse(endpoint + '/total'));
    if (response.statusCode == 200) {
      double total = double.parse(jsonDecode(response.body)["total"].toString());
      return total;
    } else {
      throw Exception('Invalid process!!!');
    }
  }

  static Future<List<Cart>> getAllCartItems() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Cart> cartItems =
          body.map((dynamic cart) => Cart.fromJson(cart)).toList();
      return cartItems;
    } else {
      throw Exception('CART ITEMS are not available');
    }
  }

    static Future<dynamic> removeCartItem(String id) async {
    Response response = await delete(Uri.parse('${endpoint}/delete/${id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Cart Item is not available');
    }
  }
}
