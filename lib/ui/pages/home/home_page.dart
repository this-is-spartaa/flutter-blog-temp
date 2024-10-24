import 'package:flutter/material.dart';
import 'package:flutter_blog_app/ui/pages/home/widgets/blog_list_view.dart';
import 'package:flutter_blog_app/ui/pages/write/write_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BLOG',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return WritePage(post: null);
            },
          ));
        },
        child: Icon(Icons.edit),
      ),
      drawer: Drawer(),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 글',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlogListView(),
            ),
          ],
        ),
      ),
    );
  }
}
