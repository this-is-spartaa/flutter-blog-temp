import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/ui/pages/home/widgets/blog_list_view.dart';
import 'package:flutter_blog_app/ui/pages/write/write_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      print(value.docs[0].data());
    },);
    final title = ['나의 개발 일지', '겨울 추위를 피해서', '테스트 입니다'];
    final images = [
      'https://i.pinimg.com/736x/4e/0d/ef/4e0def0f8238b276c4cadb8bb7b87068.jpg',
      'https://img.freepik.com/free-photo/view-breathtaking-beach-nature-landscape_23-2151682888.jpg',
      'https://i.pinimg.com/736x/55/03/c1/5503c12391704393361d5b39138c1c61.jpg',
    ];
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
              return WritePage();
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
