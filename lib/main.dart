import 'package:flutter/material.dart';
import 'package:frontend/screens/addcard.dart';

import 'screens/root_app.dart';
import 'theme/color.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/addcategory.dart';
import 'screens/addcard.dart';


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
        '/home' :(context) => const  RootApp(),
        '/addcategory' :(context) => const  AddCategory(),
        '/register' :(context) => const Register(),
        '/card' :(context) => const AddCard(),
     
       } ,

            home: Login(),
    );
  }
}
