import 'package:flutter/material.dart';
import 'package:flutter_blog_app/data/model/post.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.post);

  Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.only(bottom: 300),
        children: [
          Image.network(
              'https://i.pinimg.com/736x/4e/0d/ef/4e0def0f8238b276c4cadb8bb7b87068.jpg'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  post.writer,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  post.createdAt.toIso8601String(),
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
