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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<CourseProvider>(context).getAllCourses();
  }

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
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: Provider.of<CourseProvider>(context).courses.length,
          itemBuilder: (context, index) {
            return CourseTile(
                course: Provider.of<CourseProvider>(context)
                    .courses
                    .elementAt(index));
          },
        ),
      ),
    );
  }
}
