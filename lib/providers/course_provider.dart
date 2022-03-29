import 'package:flutter/material.dart';

import '../services/course.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  bool loading = false;

  List<Course> get courses => _courses;

  Future<void> getAllCourses() async {
    loading = true;
    _courses = await Course.getAllCourses();
    loading = false;
    notifyListeners();
  }

  Future<void> deleteCourse(String id) async {
    await Course.removeCourse(id);
    notifyListeners();
  }
}
