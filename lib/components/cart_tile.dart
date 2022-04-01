import 'package:flutter/material.dart';

import '../services/cart.dart';

class CartTile extends StatelessWidget {
  final Cart cart;
  const CartTile({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
          elevation: 3,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  cart.courseImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 150,
                child: Column(
                  children: [
                    Text(cart.courseName!,
                        style: Theme.of(context).textTheme.headline6),
                    Text(cart.coursePrice!),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
              IconButton(
                  onPressed: () {
                    Cart.removeCartItem(cart.cartId);
                  },
                  icon: Icon(
                    Icons.delete,
                  )),
            ],
          )),
    );
  }
  
}
