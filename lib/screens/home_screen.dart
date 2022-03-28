import 'package:flutter/material.dart';

import '../components/course_tile.dart';
import '../services/course.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Flexible(flex: 1, child: Text("All Items")),
          Flexible(
            flex: 20,
            child: Padding(
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
          )
        ],
      ),
    ));
  }
}
