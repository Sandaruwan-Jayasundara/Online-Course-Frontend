import 'package:flutter/material.dart';

import 'components/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Post Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Home.routName,
      routes: {Home.routName: (context) => const Home()
      },
    );
  }
}
