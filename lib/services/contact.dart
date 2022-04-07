import 'dart:convert';

import 'package:http/http.dart';

class Contact {
  static const String endpoint = "http://10.0.2.2:8070/contact";

  String? contactId;
  late final String? email;
  late final String? message;
  late final String? date;
  late final String? reply;

  Contact({this.contactId, this.email, this.message,this.date,this.reply});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        contactId: json['_id'],
        email: json['email'],
        message: json['message'],
        date: json['date'],
        reply: json['reply'],);
  }

  Map<String, dynamic> toJson() {
    return {"contactId": contactId ,"email": email, "date": date, "message":message, "reply":reply};
  }

  static Future<String?> send(Contact contact) async {
    Response response = await post(Uri.parse(endpoint + "/send"),
        body: json.encode(contact), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }


  static Future<String?> Reply(Contact contact) async {
    Response response = await post(Uri.parse(endpoint + "/reply"),
        body: json.encode(contact), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }

  static Future<String?> updateContact(Contact contact) async {
    Response response = await post(Uri.parse(endpoint + "/update"),
        body: json.encode(contact), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('failed to add new user');
    }
  }



  static Future<Contact> deleteContact(String id) async {
    Response response = await delete(Uri.parse('${endpoint}/remove/${id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('course is not available');
    }
  }



   static Future<List<Contact>> getAllMessages() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Contact> contacts =
          body.map((dynamic contact) => Contact.fromJson(contact)).toList();
      return contacts;
    } else {
      throw Exception('Users are not available');
    }
  }

}
