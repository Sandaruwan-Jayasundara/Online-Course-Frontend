import 'package:flutter/material.dart';
import 'package:frontend/screens/payment.dart';

import 'add_courses.dart';
import 'display_cart.dart';
import 'display_course.dart';
import 'home_screen.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const Addcourses(),
    const CourseDisplay(),
    const DisplayCart()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          iconSize: 20,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts),
                label: "Contact Us",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
                backgroundColor: Colors.blue)
          ]),
    );
  }
}
