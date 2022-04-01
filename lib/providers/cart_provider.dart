import 'package:flutter/material.dart';
import 'package:frontend/services/cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _cartItems = [];
  bool loading = false;
  double price = 0;

  List<Cart> get cartItem => _cartItems;
  double get total => price;

  Future<void> getAllCartItems() async {
    loading = true;
    _cartItems = await Cart.getAllCartItems();
    loading = false;
    notifyListeners();
  }

  Future<void> getTotalPrice() async {
    price = await Cart.getCartTotal();
    notifyListeners();
  }
}
