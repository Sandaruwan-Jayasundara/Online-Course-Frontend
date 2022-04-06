import 'package:flutter/material.dart';
import 'package:frontend/services/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  bool loading = false;
  double price = 0;

  List<Category> get categories => _categories;

  Future<void> getAllCategories() async {
    loading = true;
    _categories = await Category.getAllCategories();
    loading = false;
    notifyListeners();
  }
}
