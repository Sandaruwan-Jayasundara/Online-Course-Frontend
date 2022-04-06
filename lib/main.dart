import 'package:flutter/material.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/providers/category_provider.dart';
import 'package:frontend/providers/course_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/add_courses.dart';
import 'package:frontend/screens/add_user.dart';
import 'package:frontend/screens/chat.dart';
import 'package:frontend/screens/chats.dart';
import 'package:frontend/screens/contactus.dart';
import 'package:frontend/screens/display_card.dart';
import 'package:frontend/screens/display_category.dart';

import 'package:frontend/screens/display_course.dart';
import 'package:frontend/screens/display_user.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/payment.dart';
import 'package:frontend/screens/root.dart';
import 'package:frontend/screens/side_bar.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CourseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CTSE',
        theme: ThemeData(
          primaryColor: primary,
        ),
        initialRoute: '/login',
        routes: {
          '/home': (context) => const Root(),
          '/register': (context) => const Register(),
          '/card': (context) => const DisplayCard(),
          '/contact': (context) => const ContactUs(),
          '/chat': (context) => const Chats(),
          '/adduser': (context) => const AddUser(),
          '/addcategory': (context) => const AddCategory(),
          '/addcourse': (context) => const Addcourses(),
          '/login': (context) => const Login(),
          '/chatpage': (context) => const ChatPage(),
          '/course': (context) => const CourseDisplay(),
          '/category': (context) => const DisplayCategory(),
          '/user-management': (context) => const DisplayUser(),
          '/logout': (context) => const Login(),
          "/sidebar": (context) => SideBar(),
        },
      ),
    );
  }
}
