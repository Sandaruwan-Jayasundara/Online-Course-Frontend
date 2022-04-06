import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/add_user.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:frontend/screens/update_user.dart';
import 'package:frontend/services/user.dart';
import 'package:frontend/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/category.dart';

class DisplayUser extends StatefulWidget {
  const DisplayUser({Key? key}) : super(key: key);

  @override
  State<DisplayUser> createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayUser> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<UserProvider>(context).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<UserProvider>(context).users;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("283B71"),
          title: Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Management",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddUser.routeName);
                },
                icon: const Icon(Icons.ad_units))
          ],
        ),
        drawer: SideBar(),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return userTile(context, users.elementAt(index));
            }));
  }

  Widget userTile(BuildContext context, User user) {
    return (Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
          elevation: 3,
          child: Row(
            children: [
              SizedBox(width: 20),
              Container(
                width: 240,
                child: Flexible(
                  flex: 9,
                  child: Column(
                    children: [
                      Text(user.name!,
                          style: Theme.of(context).textTheme.headline6),
                      Text(user.email!),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => UpdateUser(user: user)),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                  IconButton(
                      onPressed: () {
                        _delete(context, user);
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                ],
              )
            ],
          )),
    ));
  }

  void _delete(BuildContext context, User user) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the course ?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the course

                    User.deleteUser(user.userId.toString());
                    // Close the dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/user-management',
                      (route) => false,
                    );
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
