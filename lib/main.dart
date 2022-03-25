import 'package:flutter/material.dart';
import 'package:frontend/screens/courseList.dart';
import 'screens/root_app.dart';
import 'theme/color.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/courses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CTSE',
      theme: ThemeData(
        primaryColor: primary,
      ),
       routes:{
      //   '/' :(context) => const Login(),
      //   '/register' :(context) => const Register(),
     
        '/': (context) => const CourseList(),
        '/add-product': (context) => const Courses(),
        '/edit-product': (context) => const Courses(),
           } ,
      //home: RootApp(),
    );
  }

}