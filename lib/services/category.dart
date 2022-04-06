import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class Category {
  static const String endpoint = "http://10.0.2.2:8070/category";

  late final String? categoryId;
  late final String? CategoryName;
  late final String? CategoryNumber;
  late final String? CategoryImage;

  Category(
      {this.categoryId,
      this.CategoryName,
      this.CategoryNumber,
      this.CategoryImage});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json['_id'],
        CategoryName: json['CategoryName'],
        CategoryImage: json['CategoryImage'],
        CategoryNumber: json['CategoryNumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      "CategoryName": CategoryName,
      "CategoryNumber": CategoryNumber,
      "CategoryImage": CategoryImage,
    };
  }

  static Future<dynamic?> addNewCategory(Category category, File image) async {
    try {
      dio.Dio _dio = dio.Dio();
      String fileName = image.path.split("/").last;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(image.path,
            filename: fileName, contentType: new MediaType('image', 'png')),
        "type": "image/png",
        "CategoryName": category.CategoryName,
        "CategoryNumber": category.CategoryNumber,
      });
      dio.Response response = await _dio.post('$endpoint/add',
          data: formData,
          options: dio.Options(headers: {
            "accept": "*/*",
            "Authorization": "Bearer accresstoken",
            "Content-Type": "multipart/form-data"
          }));
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> updateCategoryWithoutImage(Category category) async {
    try {
      dio.Dio _dio = dio.Dio();
      dio.FormData formData = dio.FormData.fromMap({
        "file": null,
        "type": "image/png",
        "CategoryName": category.CategoryName,
        "CategoryNumber": category.CategoryNumber,
        "CategoryImage": category.CategoryImage,
      });
      dio.Response response =
          await _dio.patch('$endpoint/update/${category.categoryId}',
              data: formData,
              options: dio.Options(headers: {
                "accept": "*/*",
                "Authorization": "Bearer accresstoken",
                "Content-Type": "multipart/form-data"
              }));
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> updateCategory(Category category, File image) async {
    try {
      dio.Dio _dio = dio.Dio();
      String fileName = image.path.split("/").last;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(image.path,
            filename: fileName, contentType: new MediaType('image', 'png')),
        "type": "image/png",
        "CategoryName": category.CategoryName,
        "CategoryNumber": category.CategoryNumber,
      });
      dio.Response response =
          await _dio.patch('$endpoint/update/${category.categoryId}',
              data: formData,
              options: dio.Options(headers: {
                "accept": "*/*",
                "Authorization": "Bearer accresstoken",
                "Content-Type": "multipart/form-data"
              }));
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Category>> getAllCategories() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Category> categories =
          body.map((dynamic category) => Category.fromJson(category)).toList();
      return categories;
    } else {
      throw Exception('Category are not available');
    }
  }

  static Future<Category> removeCategory(String id) async {
    Response response = await delete(Uri.parse('${endpoint}/delete/${id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('course is not available');
    }
  }

  static Future<Category> getCourseById(String id) async {
    Response response = await get(Uri.parse(endpoint + '/${id}'));
    if (response.statusCode == 200) {
      Category course = jsonDecode(response.body);
      return course;
    } else {
      throw Exception('course is not available');
    }
  }
}
