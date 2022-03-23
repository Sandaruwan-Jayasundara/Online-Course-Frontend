import 'dart:convert';

import 'package:http/http.dart';

class Course {
  static const String endpoint = "http://10.0.2.2:8070/courses";

  late final String? courseId;
  late final String? courseName;
  late final int? courseDuration;
  late final double? price;

  Course({this.courseId, this.courseName, this.courseDuration, this.price});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseId: json['coureId'],
        courseName: json['courseName'],
        courseDuration: json['courseDuration'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      "courseName": courseName,
      "courseDuration": courseDuration,
      "price": price
    };
  }

  Future<String?> addNewCourse(Course course) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(course),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('Failed to added the course');
    }
  }

  Future<List<Course>> getAllCourses() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Course> courses =
          body.map((dynamic course) => Course.fromJson(course)).toList();
      return courses;
    } else {
      throw Exception('Courses are not available');
    }
  }


  Future<Course> getCourseById(String id)async{
        Response response = await get(Uri.parse(endpoint+'/${id}'));
    if (response.statusCode == 200) {
      Course course= jsonDecode(response.body);
      return course;
    } else {
      throw Exception('course is not available');
    }
  }
}
