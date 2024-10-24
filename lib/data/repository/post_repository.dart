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

  Stream<List<Post>> postListStream() {
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

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
    required String imageUrl,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('post').doc();
      final newPost = Post(
        id: docRef.id,
        writer: writer,
        title: title,
        content: content,
        imgUrl: imageUrl,
        createdAt: DateTime.now(),
      );
      await docRef.set(newPost.toJson());
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> update({
    required String id,
    required String writer,
    required String title,
    required String content,
    required String imageUrl,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('post').doc(id);
      await docRef.update({
        'writer': writer,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Stream<Post?> postStream(String id) {
    final snapshot = FirebaseFirestore.instance.collection('post').doc(id);
    return snapshot.snapshots().map(
      (e) {
        if (e.data() == null) {
          return null;
        }
        return Post.fromJson(e.data()!);
      },
    );
  }

  Future<bool> delete(String id) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('post').doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }
}
