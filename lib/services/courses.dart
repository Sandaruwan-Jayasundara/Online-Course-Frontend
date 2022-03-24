import 'dart:convert';

import 'package:http/http.dart';

class Course {
  static const String endpoint = "http://10.0.2.2:8070/auth";

  String? courseId;
  late final String? courseName;
  late final int? coursePrice;
  late final String? courseImage;

  Course({this.courseId, this.courseName, this.coursePrice, this.courseImage});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseId: json['courseId'],
        courseName: json['courseName'],
        coursePrice: json['coursePrice'],
        courseImage: json['courseImage']);
  }

  Map<String, dynamic> toJson() {
    return {"courseName": courseName, "coursePrice": coursePrice, "courseImage": courseImage};
  }

  static Future<String?> addCourse(Course course) async {
    Response response = await post(Uri.parse(endpoint + "/addcourse"),
        body: json.encode(course), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }

  static Future<bool> loginUser(Course course) async {
    Response response = await post(Uri.parse(endpoint + "/login"),
        body: json.encode(course), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid user');
    }
  }
}
