import 'package:flutter/material.dart';
import 'screens/root_app.dart';
import 'theme/color.dart';
import 'screens/login.dart';
import 'screens/register.dart';

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
      // routes:{
      //   '/' :(context) => const Login(),
      //   '/register' :(context) => const Register(),
      // } ,

      home: Login(),
    );
  }
}
