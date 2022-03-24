import 'package:flutter/material.dart';
import 'package:frontend/screens/view_user.dart';

import '../services/user.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: const Center(child: Text('User List'))),
      body: FutureBuilder(
          future: User.getAllUsers(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            List<User>? users = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 3,
                children: users!
                    .map((User user) => Card(
                          child: ListTile(
                            title: Text(user.name!),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewUser(user: user)));
                            },
                          ),
                        ))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}