import 'dart:convert';

import 'package:frontend/screens/displayCard.dart';
import 'package:http/http.dart';

class CreditCard {
  static const String endpoint = "http://10.0.2.2:8070/card";

  String? cardId;
  late final String? cardNumber;
  late final String? cardName;
  late final int? cvv;
  late final String? date;
  CreditCard({this.cardId, this.cardNumber, this.cardName,this.cvv, this.date});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        cardId: json['cardId'],
        cardNumber: json['cardNumber'],
        cardName: json['cardName'],
        cvv: json['cvv'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {"cardNumber": cardNumber, "cardName": cardName, "cvv": cvv, "date":date};
  }

  static Future<String?> saveCard(CreditCard card) async {
    Response response = await post(Uri.parse(endpoint + "/add"),
        body: json.encode(card), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('process failed');
    }
  }

  static Future<String?> DisplayCard() async {
    Response response = await get(Uri.parse(endpoint + "/display"), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception('process failed');
    }
  }










}
