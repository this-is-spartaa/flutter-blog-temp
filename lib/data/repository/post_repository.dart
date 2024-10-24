import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blog_app/data/model/post.dart';

class PostRepository {
  const PostRepository();
  Future<List<Post>?> getAll() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('post').get();
      return snapshot.docs.map(
        (e) {
          return Post.fromJson(e.data());
        },
      ).toList();
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
