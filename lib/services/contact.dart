import 'dart:convert';

import 'package:http/http.dart';

class Contact {
  static const String endpoint = "http://10.0.2.2:8070/contact";

  String? contactId;
  late final String? name;
  late final String? text;
  late final String? date;


  Contact({this.contactId, this.name, this.text,this.date});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        contactId: json['contactId'],
        name: json['name'],
        text: json['text'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "date": date, "text":text};
  }

   static Future<List<Contact>> getAllUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Contact> users =
          body.map((dynamic course) => Contact.fromJson(course)).toList();
      return users;
    } else {
      throw Exception('Users are not available');
    }
  }

}
