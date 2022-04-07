import 'package:flutter/material.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/services/user.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];
  bool loading = false;


  List<Contact> get contacts => _contacts;


  Future<void> getAllMessage() async {
    loading = true;
    _contacts = await Contact.getAllMessages();
    loading = false;
    notifyListeners();
  }

}
