import 'dart:convert';

import 'package:http/http.dart';

class User {
  static const String endpoint = "http://10.0.2.2:8070/auth";

  late final String? userId;
  late final String? name;
  late final String? email;
  late final String? type;
  late final String? password;

  User({this.userId, this.name, this.type,this.email, this.password});



 factory User.fromJson(Map<String, dynamic> json) {
    print("aaaaaaaaa");
    return User(
        userId: json['_id'],
        email: json['name'],
        name: json['email'],
        type: json['type'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
      "name": name,
      "type": type,
      "password": password,
    };
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

  static Future<String?> updateUser(User user) async {
    Response response = await post(Uri.parse(endpoint + "/update"),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }




  static Future<User> deleteUser(String id) async {
    Response response = await delete(Uri.parse('${endpoint}/delete/${id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('course is not available');
    }
  }




  static Future<String> loginUser(User user) async {
    Response response = await post(Uri.parse(endpoint + "/login"),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }


  static Future<String?> addNewUser(User user) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(user), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }


  static Future<List<User>> getAllUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users =
          body.map((dynamic user) => User.fromJson(user)).toList();
      return users;
    } else {
      throw Exception('categories are not available');
    }
  }


}
