import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/view_course.dart';
import '../services/course.dart';

class HomeCourseTile extends StatelessWidget {
  final Course course;
  const HomeCourseTile({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewCourse(course: course)));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          elevation: 3,
          child: Column(
            children: [
              Expanded(child: Image(image: AssetImage(course.courseImage))),
              Text(
                course.courseName,
                style: GoogleFonts.oswald(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                'Rs ${course.coursePrice}.00',
                style: GoogleFonts.oswald(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
