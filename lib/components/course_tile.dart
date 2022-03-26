import 'package:flutter/material.dart';

import '../services/course.dart';

class CourseTile extends StatelessWidget {
  final Course course;
  const CourseTile({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Expanded(child: Image.asset(course.courseImage)),
            Text(
              course.courseName,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${course.coursePrice}',
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.update)),
                SizedBox(
                  width: 20,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
