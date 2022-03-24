import 'package:flutter/material.dart';
import 'package:posts/components/view-post.dart';

import '../services/post.dart';

class Home extends StatelessWidget {
  static const String routName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Post List'))),
      body: FutureBuilder(
          future: Post.getAllPosts(),
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            List<Post>? posts = snapshot.data;
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 3,
                children: posts!
                    .map((Post post) => Card(
                          child: ListTile(
                            title: Text(post.title),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewPost(post: post)));
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
