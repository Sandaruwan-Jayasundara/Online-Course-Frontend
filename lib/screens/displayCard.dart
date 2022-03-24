import 'package:flutter/material.dart';
import 'package:lab3/data.dart';
import 'package:lab3/pages/cart.dart';

import '../components/item_tile.dart';

class DisplayCard extends StatelessWidget {
  static String routeName = '/displaycard';
  const DisplayCard({Key? key}) : super(key: key);

  String get cardNumber => null;

  get cardName => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("My Store")),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: storeItems.length,
          itemBuilder: (context, index) {
            return ItemTile(item: storeItems.elementAt(index));
          },
        ),
      ),
    );
  }
}
