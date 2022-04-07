import 'package:flutter/material.dart';
import 'package:frontend/utils/data.dart';
import 'package:frontend/widgets/chat_item.dart';
import 'package:frontend/widgets/custom_textfield.dart';

class DisplayContact extends StatefulWidget {
  const DisplayContact({ Key? key }) : super(key: key);

  @override
  _DisplayContactState createState() => _DisplayContactState();
}

class _DisplayContactState extends State<DisplayContact> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody(){
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          getHeader(),
          getChats(),
        ]
      ),
    );
  }

  getHeader(){
    return
      Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Chat", 
                      style: TextStyle(fontSize: 28, 
                      
                      color: Colors.black87, fontWeight: FontWeight.w600,
                      
                      )
                    ,)
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomTextBox(hint: "Search", prefix: Icon(Icons.search, color: Colors.grey), ),
          ],
        )
      );
  }

  getChats(){
    return
      ListView(
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        children: List.generate(chats.length, 
        (index) => ChatItem(chats[index],
            onTap: (){
              
            },
          )
        )
    );
  }
}
