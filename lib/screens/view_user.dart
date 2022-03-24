import 'package:flutter/material.dart';
import '../services/user.dart';

class ViewUser extends StatelessWidget {
  static const String routName = '/view_user';
  final User user;
  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name!)),
      body: Column(children: [Text("Name: ${user.name}")]),
    );
  }
}
