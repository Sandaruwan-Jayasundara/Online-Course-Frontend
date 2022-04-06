import 'package:flutter/material.dart';
import 'package:frontend/services/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool loading = false;
  User? _currentUser;

  List<User> get users => _users;
  String? get name => (_currentUser!.name);

  Future<void> getAllUsers() async {
    loading = true;
    _users = await User.getAllUsers();
    loading = false;
    notifyListeners();
  }

  void set currentUser(User user) {
    _currentUser = user;
  }
}
