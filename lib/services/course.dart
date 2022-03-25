import 'dart:convert';

import 'package:http/http.dart';

class Course {
  static const String endpoint = "http://10.0.2.2:8070/course";

  late final String? courseId;
  late final String? courseName;
    late final String? courseImage;
  late final int? courseDuration;
  late final double? coursePrice;

  Course({this.courseId, this.courseName,this.courseImage, this.courseDuration, this.coursePrice});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseId: json['coureId'],
        courseName: json['courseName'],
        courseDuration: json['courseDuration'],
        courseImage: json['courseImage'],
        coursePrice: json['coursePrice']);
  }

  Map<String, dynamic> toJson() {
    return {
      "courseName": courseName,
      "courseDuration": courseDuration,
      "courseImage": courseImage,
      "coursePrice": coursePrice
    };
  }

  static Future<String?> addNewCourse(Course course) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(course), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }



  static Future<List<Course>> getAllCourses() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<Course> courses =
          body.map((dynamic course) => Course.fromJson(course)).toList();
      return courses;
    } else {
      throw Exception('Courses are not available');
    }
  }





  static Future<Course> getCourseById(String id)async{
        Response response = await get(Uri.parse(endpoint+'/${id}'));
    if (response.statusCode == 200) {
      Course course= jsonDecode(response.body);
      return course;
    } else {
      throw Exception('course is not available');
    }
  }
}
