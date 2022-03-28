import 'package:flutter/material.dart';
import 'package:frontend/screens/display_course.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../screens/update_course.dart';
import '../services/course.dart';

class CourseTile extends StatefulWidget {
  final Course course;
  const CourseTile({Key? key, required this.course}) : super(key: key);

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Expanded(child: Image.asset(widget.course.courseImage)),
            Text(
              widget.course.courseName,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${widget.course.coursePrice}',
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UpdateCourse(course: widget.course)));
                    },
                    icon: Icon(Icons.update)),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      _delete(context);
                    },
                    icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the course ?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the course

                    Course.removeCourse(widget.course.courseId);
                    // Close the dialog
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}