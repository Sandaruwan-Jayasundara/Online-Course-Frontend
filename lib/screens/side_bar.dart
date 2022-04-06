import 'package:flutter/material.dart';
import 'package:frontend/screens/home.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Welcome ${Provider.of<UserProvider>(context, listen: false).name!}!!!',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/admin.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Course'),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/course',
                (route) => false,
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Category'),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/category',
                (route) => false,
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('User Management'),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/user-management',
                (route) => false,
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Contact'),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/chatpage',
                (route) => false,
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/logout',
                (route) => false,
              )
            },
          ),
        ],
      ),
    );
  }
}
