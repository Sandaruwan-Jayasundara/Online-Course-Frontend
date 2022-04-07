import 'package:flutter/material.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:frontend/services/course.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../components/course_splash.dart';
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
        backgroundColor: Colors.orange,
        title: Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "Course",
                  style: GoogleFonts.oswald(fontSize: 25),
                ),
              )),
        ),
        actions: [
          Tooltip(
            waitDuration: Duration(seconds: 1),
            showDuration: Duration(seconds: 2),
            message: 'Add New Course',
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnimatedSplashScreen(
                          splash: Icons.add_sharp,
                          splashTransition: SplashTransition.fadeTransition,
                          duration: 3000,
                          nextScreen: Addcourses())));
                },
                icon: const Icon(Icons.add_sharp)),
          )
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
