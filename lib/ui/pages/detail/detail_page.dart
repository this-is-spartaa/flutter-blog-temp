import 'package:flutter/material.dart';
import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/ui/pages/detail/detail_view_model.dart';
import 'package:flutter_blog_app/ui/pages/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  DetailPage(this.postId);

  String postId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModel(postId));
    final vm = ref.read(detailViewModel(postId).notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          button(Icons.delete, () async {
            // TODO Modal
            final result = await vm.delete();
            if (result) {
              Navigator.pop(context);
            }
          }),
          button(Icons.edit, () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return WritePage(post: state);
              },
            ));
          }),
        ],
      ),
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
                  state?.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  state?.writer ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  state?.createdAt.toIso8601String() ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  state?.content ?? '',
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

  GestureDetector button(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent, // for touch area
        width: 50,
        height: 50,
        child: Icon(icon),
      ),
    );
  }
}
