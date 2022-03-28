import 'package:flutter/material.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/services/course.dart';
import 'package:provider/provider.dart';

import '../components/course_tile.dart';
import '../providers/course_provider.dart';

class CourseDisplay extends StatefulWidget {
  const CourseDisplay({Key? key}) : super(key: key);

  @override
  State<CourseDisplay> createState() => _CourseDisplayState();
}

class _CourseDisplayState extends State<CourseDisplay> {
  Future<List<Course>> courses = Course.getAllCourses();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("ADMIN COURSE")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Addcourses.routeName);
              },
              icon: const Icon(Icons.ad_units))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: Course.getAllCourses(),
            builder: (context, AsyncSnapshot<List<Course>> snapshot) {
              List<Course>? courses = snapshot.data;
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: courses!
                      .map((Course course) => CourseTile(course: course))
                      .toList(),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
