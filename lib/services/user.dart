import 'dart:convert';

import 'package:http/http.dart';

class User {
  static const String endpoint = "http://10.0.2.2:8070/auth";

  String? userId;
  late final String? name;
  late final String? email;
  late final String? password;

  User({this.userId, this.name, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }

  static Future<String?> registerUser(User user) async {
    Response response = await post(Uri.parse(endpoint + "/register"),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }

  static Future<bool> loginUser(User user) async {
    Response response = await post(Uri.parse(endpoint + "/login"),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid user');
    }
  }
}
