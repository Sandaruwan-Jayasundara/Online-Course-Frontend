import 'dart:convert';

import 'package:http/http.dart';

class Post {
  static const String endpoint = "https://jsonplaceholder.typicode.com/posts";
  final int userId;
  final int id;
  final String title;
  final String body;


  const Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }

  static Future<List<Post>> getAllPosts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Post> posts =
          body.map((dynamic post) => Post.fromJson(post)).toList();
      return posts;
    } else {
      throw Exception('Posts are not available');
    }
  }
}
