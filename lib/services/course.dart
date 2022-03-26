import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class Course {
  static const String endpoint = "http://10.0.2.2:8070/course";
  final String courseId;
  final String courseName;
  final String courseImage;
  final String courseDuration;
  final String coursePrice;

  Course(
      {required this.courseId,
      required this.courseName,
      required this.courseImage,
      required this.courseDuration,
      required this.coursePrice});

  factory Course.fromJson(Map<String, dynamic> json) {
    Course course = Course(
      courseId: json['_id'],
      courseName: json['courseName'],
      courseImage: json['courseImage'],
      courseDuration: json['courseDuration'].toString(),
      coursePrice: json['coursePrice'].toString(),
    );
    print(course.courseId);
    return course;
  }

  Map<String, dynamic> toJson() {
    return {
      "courseName": courseName,
      "courseDuration": courseDuration,
      "courseImage": courseImage,
      "coursePrice": coursePrice
    };
  }

  static Future<dynamic?> addNewCourse(Course course, File image) async {
    try {
      dio.Dio _dio = dio.Dio();
      String fileName = image.path.split("/").last;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(image.path,
            filename: fileName, contentType: new MediaType('image', 'png')),
        "type": "image/png",
        "courseName": course.courseName,
        "coursePrice": course.coursePrice,
        "courseDuration": course.courseDuration
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

  static Future<List<Course>> getAllCourses() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Course> courses =
          body.map((dynamic course) => Course.fromJson(course)).toList();
      print(courses);
      return courses;
    } else {
      throw Exception('Courses are not available');
    }
  }

  static Future<Course> getCourseById(String id) async {
    Response response = await get(Uri.parse(endpoint + '/${id}'));
    if (response.statusCode == 200) {
      Course course = jsonDecode(response.body);
      return course;
    } else {
      throw Exception('course is not available');
    }
  }
}
