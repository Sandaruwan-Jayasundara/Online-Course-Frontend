import 'package:flutter/material.dart';

import '../screens/view_course.dart';
import '../services/course.dart';

class HomeCourseTile extends StatelessWidget {
  final Course course;
  const HomeCourseTile({Key? key,required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                             ViewCourse(course: course))); 
      },
      child: Padding(
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
              
            ],
          ),
        ),
      ),
    );
  }
}
