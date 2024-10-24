import 'dart:async';

import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModel =
    NotifierProvider.autoDispose<HomeViewModel, List<Post>?>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeNotifier<List<Post>?> {
  HomeViewModel();

  @override
  List<Post>? build() {
    fetchData();
    return null;
  }

  final postRepository = const PostRepository();

  Future<void> fetchData() async {
    // state = await postRepository.getAll();
    final stream = postRepository.postListStream();
    final streamSubscription = stream.listen(
      (newList) {
        state = newList;
      },
    );

    ref.onDispose(
      () {
        streamSubscription.cancel();
      },
    );
  }
}
