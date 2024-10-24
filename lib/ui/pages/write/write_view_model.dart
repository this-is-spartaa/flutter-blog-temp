import 'dart:async';

import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final writeViewModel = StateNotifierProvider.autoDispose<WriteViewModel, WritePageState>(
  (ref) => WriteViewModel(const WritePageState(false)),
);

class WritePageState {
  const WritePageState(this.isWriting);
  final bool isWriting;
}

class WriteViewModel extends StateNotifier<WritePageState> {
  WriteViewModel(super._state);

  final postRepository = const PostRepository();

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (writer.isEmpty || title.isEmpty || content.isEmpty) {
      return false;
    }
    state = const WritePageState(true);
    final newPost = await postRepository.insert(
      writer: writer,
      title: title,
      content: content,
    );
    await Future.delayed(Duration(seconds: 1));
    state = const WritePageState(false);
    return newPost;
  }
}
