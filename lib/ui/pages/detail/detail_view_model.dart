import 'dart:async';

import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailViewModel =
    StateNotifierProvider.family.autoDispose<DetailViewModel, Post?, String>(
  (ref, postId) => DetailViewModel(null, postId)..listenStream(),
);

class DetailViewModel extends StateNotifier<Post?> {
  DetailViewModel(super._state, this.postId);

  final String postId;

  final postRepository = const PostRepository();

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  StreamSubscription? streamSubscription;

  void listenStream() async {
    streamSubscription = postRepository.postStream(postId).listen(
      (post) {
        state = post;
      },
    );
  }

  Future<bool> delete() async {
    return await postRepository.delete(postId);
  }
}
