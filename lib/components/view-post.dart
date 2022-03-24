import 'package:flutter/material.dart';
import 'package:posts/services/post.dart';

class ViewPost extends StatelessWidget {
  static const String routName = '/view_post';
  final Post post;
  const ViewPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Column(children: [
        Text("Title: ${post.title}"),
        ElevatedButton(
            onPressed: () {
              print("pressed");
            },
            child: const Text("Deleted"))
      ]),
    );
  }
}
