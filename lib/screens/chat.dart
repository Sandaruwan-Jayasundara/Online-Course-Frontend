import 'package:flutter/material.dart';
import 'package:frontend/screens/ViewContact.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/add_user.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:frontend/screens/update_user.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/services/user.dart';
import 'package:frontend/theme/color.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/category.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     backgroundColor: HexColor("283B71"),
            title:Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Chats", 
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)
                    ,)
                  ),
                ),
      ),
   drawer: SideBar(),
      body:ListTileTheme(

          iconColor: Colors.red,
          textColor: Colors.black54,
         
          style: ListTileStyle.list,
               child: FutureBuilder(
                  future: Contact.getAllMessages(),
                  builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
                    List<Contact>? contacts = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                   crossAxisCount: 1,


                
                children: contacts!
                    .map((Contact contact) => Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          
                             child: ListTile(
                              title: Text(contact.email!, style: TextStyle(fontSize: 20),),
                               subtitle:Text(contact.date!, style: TextStyle(fontSize: 20),),

  trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ViewContact(contact: contact)),
                          );
                                            
                    }, icon: Icon(Icons.edit)),
                     
                       IconButton(onPressed: () {

                      _delete(context ,contact);
                    }, icon: Icon(Icons.delete)),
 
                  ],
                ),
                 
                          ),
                        ))
                    .toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
             )
     );









     
  }

  void _delete(BuildContext context, Contact contact) {
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

                    Contact.deleteContact(contact.contactId.toString());
                    // Close the dialog
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/chatpage',
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

