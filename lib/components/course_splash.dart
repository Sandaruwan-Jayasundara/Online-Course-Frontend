import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/add_courses.dart';

class CourseSplash extends StatefulWidget {
  const CourseSplash({Key? key}) : super(key: key);

  @override
  State<CourseSplash> createState() => _CourseSplashState();
}

class _CourseSplashState extends State<CourseSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToAddCourse();
  }

  _navigateToAddCourse() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Addcourses()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 100, width: 100, color: Colors.blue),
          Container(
            child: Text('Loading to Add New Course Page....',
                style: GoogleFonts.oswald(
                    fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ));
  }
}
