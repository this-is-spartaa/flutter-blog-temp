import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final writeViewModel = StateNotifierProvider.family
    .autoDispose<WriteViewModel, WritePageState, Post?>(
  (ref, post) => WriteViewModel(
    WritePageState(false, post?.imgUrl),
    post,
  ),
);

class WritePageState {
  const WritePageState(
    this.isWriting,
    this.imageUrl,
  );
  final bool isWriting;
  final String? imageUrl;
}

class WriteViewModel extends StateNotifier<WritePageState> {
  WriteViewModel(super._state, this.post);

  Post? post;

  final postRepository = const PostRepository();

  Future<void> pickImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      try {
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef = storageRef
            .child('${DateTime.now().microsecondsSinceEpoch}_${xFile.name}');
        await imageRef.putFile(File(xFile.path));
        final url = await imageRef.getDownloadURL();
        state = WritePageState(false, url);
      } catch (e) {
        log('$e');
      }
    }
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (writer.isEmpty ||
        title.isEmpty ||
        content.isEmpty ||
        state.imageUrl == null) {
      return false;
    }
    if (post?.content == content &&
        post?.title == title &&
        writer == post?.writer && post?.imgUrl == state.imageUrl) {
      return false;
    }
    state = WritePageState(true, state.imageUrl);

    final result = post == null
        ? await postRepository.insert(
            writer: writer,
            title: title,
            content: content,
            imageUrl: state.imageUrl!)
        : await postRepository.update(
            id: post!.id,
            writer: writer,
            title: title,
            content: content,
            imageUrl: state.imageUrl!,
          );

    await Future.delayed(Duration(seconds: 1));
    state = WritePageState(false, state.imageUrl);
    return result;
  }
}
