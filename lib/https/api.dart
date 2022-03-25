import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/CourseModel.dart';
import 'config.dart';


class Api {
  static var client = http.Client();

  static Future<List<CourseModel>?> getCourse() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.courseAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return courseFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveCourse(
    CourseModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var courseURL = Config.courseAPI;

    if (isEditMode) {
     courseURL =courseURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, courseURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["courseName"] = model.courseName!;
    request.fields["coursePrice"] = model.coursePrice!.toString();

    if (model.courseImage != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'coursesImage',
        model.courseImage!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteCourse(courseId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.courseAPI + "/" + courseId,
    );

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}