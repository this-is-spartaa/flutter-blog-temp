import 'dart:async';

import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final writeViewModel = StateNotifierProvider.family
    .autoDispose<WriteViewModel, WritePageState, Post?>(
  (ref, post) => WriteViewModel(
    const WritePageState(false),
    post,
  ),
);

class WritePageState {
  const WritePageState(this.isWriting);
  final bool isWriting;
}

class WriteViewModel extends StateNotifier<WritePageState> {
  WriteViewModel(super._state, this.post);

  Post? post;

  final postRepository = const PostRepository();

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (writer.isEmpty || title.isEmpty || content.isEmpty) {
      return false;
    }
    if (post?.content == content &&
        post?.title == title &&
        writer == post?.writer) {
      return false;
    }
    state = const WritePageState(true);

    final result = post == null
        ? await postRepository.insert(
            writer: writer,
            title: title,
            content: content,
          )
        : await postRepository.update(
            id: post!.id,
            writer: writer,
            title: title,
            content: content,
          );

    await Future.delayed(Duration(seconds: 1));
    state = const WritePageState(false);
    return result;
  }
}
