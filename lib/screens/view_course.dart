import 'package:flutter/material.dart';

import '../services/course.dart';

class ViewCourse extends StatelessWidget {
  final Course course;
  const ViewCourse({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course.courseName}'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                course.courseImage,
                width: 800,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${course.courseName}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              '${course.courseDescription}',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Text(
              'Course price: ${course.coursePrice}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Add To Cart")),
          ],
        ),
      ),
    );
  }
}
