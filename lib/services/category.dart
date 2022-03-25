import 'dart:convert';

import 'package:http/http.dart';

class Category {
  static const String endpoint = "http://10.0.2.2:8070/category";

  late final String? categoryId;
  late final String? CategoryName;
  late final String? CategoryNumber;


  Category({this.categoryId, this.CategoryName,this.CategoryNumber});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json['categoryId'],
        CategoryName: json['CategoryName'],
        CategoryNumber: json['CategoryNumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      "CategoryName": CategoryName,
      "CategoryNumber": CategoryNumber,
    };
  }

  static Future<String?> addNewCategory(Category course) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(course), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }




  static Future<List<Category>> getAllCourses() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<Category> courses =
          body.map((dynamic course) => Category.fromJson(course)).toList();
      return courses;
    } else {
      throw Exception('Courses are not available');
    }
  }


  static Future<Category> getCourseById(String id)async{
        Response response = await get(Uri.parse(endpoint+'/${id}'));
    if (response.statusCode == 200) {
      Category course= jsonDecode(response.body);
      return course;
    } else {
      throw Exception('course is not available');
    }
  }
}
