import 'package:flutter/material.dart';
import 'package:frontend/screens/payment.dart';
import 'package:frontend/screens/root.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/cart_tile.dart';
import '../providers/cart_provider.dart';
import '../services/cart.dart';

class DisplayCart extends StatefulWidget {
  const DisplayCart({Key? key}) : super(key: key);

  @override
  State<DisplayCart> createState() => _DisplayCartState();
}

class _DisplayCartState extends State<DisplayCart> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<CartProvider>(context).getAllCartItems();
    Provider.of<CartProvider>(context).getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    List<Cart> items = Provider.of<CartProvider>(context).cartItem;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Center(
            child: Text("Cart"),
          ),
          actions: [
            IconButton(
                onPressed: Provider.of<CartProvider>(context).total != 0
                    ? () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Payment()));
                      }
                    : null,
                icon: Icon(Icons.shopping_cart_checkout))
          ],
        ),
        body: items.length != 0
            ? Column(
                children: [
                  Flexible(
                      flex: 9,
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CartTile(cart: items.elementAt(index));
                          })),
                  Flexible(
                    flex: 1,
                    child: Text(
                      'Rs. ${Provider.of<CartProvider>(context).total.toString()}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 40,
                  ),
                  Text("Cart is empty",
                      style: GoogleFonts.oswald(fontSize: 25)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Root()));
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.orange,
                        onSurface: Colors.grey,
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                      child: Text("Start Shopping",
                          style: GoogleFonts.oswald(fontSize: 15)))
                ],
              ));
  }
}
