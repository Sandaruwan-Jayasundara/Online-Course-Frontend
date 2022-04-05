import 'package:flutter/material.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:frontend/services/course.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

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
              backgroundColor: HexColor("283B71"),
               title:Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Course", 
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)
                    ,)
                  ),
                ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Addcourses.routeName);
              },
              icon: const Icon(Icons.ad_units))
        ],
      ),
     drawer: SideBar(),
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
