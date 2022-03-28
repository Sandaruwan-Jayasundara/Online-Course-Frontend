import 'package:flutter/material.dart';
import 'package:frontend/providers/course_provider.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/screens/add_user.dart';
import 'package:frontend/screens/admin_root_app%20.dart';
import 'package:frontend/screens/chats.dart';
import 'package:frontend/screens/contactus.dart';
import 'package:frontend/screens/display_card.dart';
import 'package:frontend/screens/display_category.dart';

import 'package:frontend/screens/display_course.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/payment.dart';
import 'package:frontend/screens/root.dart';
import 'package:provider/provider.dart';

import 'screens/root_app.dart';
import 'theme/color.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/add_category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CTSE',
        theme: ThemeData(
          primaryColor: primary,
        ),
        routes: {
          '/home': (context) => const RootApp(),
          '/register': (context) => const Register(),
          '/card': (context) => const DisplayCard(),
          '/contact': (context) => const ContactUs(),
          '/chat': (context) => const Chats(),
          '/adduser': (context) => const AddUser(),
          '/addcategory': (context) => const AddCategory(),
          '/addcourse': (context) => const Addcourses(),
          '/category': (context) => const DisplayCategory(),
          '/admin': (context) => const AdminRootApp(),
        },
        home: Root(),
      ),
    );
  }
}
