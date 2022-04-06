import 'package:flutter/material.dart';
import 'package:frontend/screens/chats.dart';
import 'package:frontend/screens/display_cart.dart';
import 'package:frontend/screens/payment.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../services/cart.dart';
import 'add_courses.dart';
import 'display_course.dart';
import 'home_screen.dart';
import 'Account.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const Chats(),
    const DisplayCart(),
    const AccountPage(),
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<CartProvider>(context).getAllCartItems();
  }

  @override
  Widget build(BuildContext context) {
    List<Cart> items = Provider.of<CartProvider>(context).cartItem;
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
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts),
                label: "Contact Us",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Badge(
                  shape: BadgeShape.circle,
                  position: BadgePosition.topEnd(top: 10, end: 10),
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.shopping_cart),
                  badgeContent: Text(
                    '${items.length}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                label: "Cart",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Account",
                backgroundColor: Colors.blue),
          ]),
    );
  }
}
