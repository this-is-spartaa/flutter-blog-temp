import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blog_app/data/model/post.dart';

class PostRepository {
  const PostRepository();
  Future<List<Post>?> getAll() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('post')
          .orderBy('createdAt', descending: true)
          .get();
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

  Future<Stream<List<Post>>> postListStream() async {
    final collectionRef = FirebaseFirestore.instance
        .collection('post')
        .orderBy('createdAt', descending: true);
    return collectionRef.snapshots().map(
      (event) {
        return event.docs.map(
          (doc) {
            return Post.fromJson(doc.data());
          },
        ).toList();
      },
    );
  }
}
