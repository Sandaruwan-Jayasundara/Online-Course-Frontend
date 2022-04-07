import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/contact_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/ViewContact.dart';
import 'package:frontend/screens/add_category.dart';
import 'package:frontend/screens/add_user.dart';
import 'package:frontend/screens/side_bar.dart';
import 'package:frontend/screens/update_user.dart';
import 'package:frontend/services/contact.dart';
import 'package:frontend/services/user.dart';
import 'package:frontend/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/category.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<ContactProvider>(context).getAllMessage();
  }

  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = Provider.of<ContactProvider>(context).contacts;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "Contact",
                  style: GoogleFonts.oswald(fontSize: 25),
                ),
              )),
        ),

        ),
        drawer: SideBar(),
        body: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return chatTile(context, contacts.elementAt(index));
            }));
  }

  Widget chatTile(BuildContext context, Contact contact) {
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
                     
                      Text(contact.email!,
                          style: Theme.of(context).textTheme.headline6),
                      Text(contact.message!),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
              )
            ],
          )),
    ));
  }

  void _delete(BuildContext context, Contact contact) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the message ?'),
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

