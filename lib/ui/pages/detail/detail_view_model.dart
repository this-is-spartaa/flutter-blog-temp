import 'dart:async';

import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailViewModel =
    NotifierProvider.autoDispose.family<DetailViewModel, Post?, String>(
  () => DetailViewModel(),
  // DetailViewModel.new
);

class DetailViewModel extends AutoDisposeFamilyNotifier<Post?, String> {
  @override
  Post? build(String arg) {
    listenStream();
    return null;
  }

  final postRepository = const PostRepository();

  void listenStream() async {
    final streamSubscription = postRepository.postStream(arg).listen(
      (post) {
        state = post;
      },
    );
    ref.onDispose(
      () {
        print("DISPOSE 됨");
        streamSubscription.cancel();
      },
    );
  }

  Future<bool> delete() async {
    return await postRepository.delete(arg);
  }
}
