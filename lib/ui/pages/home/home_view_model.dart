import 'dart:async';

import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModel =
    StateNotifierProvider.autoDispose<HomeViewModel, List<Post>?>(
  (ref) => HomeViewModel(null)..fetchData(),
);

class HomeViewModel extends StateNotifier<List<Post>?> {
  HomeViewModel(super._state);

  final postRepository = const PostRepository();

  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  Future<void> fetchData() async {
    // state = await postRepository.getAll();
    final stream = postRepository.postListStream();
    streamSubscription = stream.listen(
      (newList) {
        if (mounted) {
          state = newList;
        }
      },
    );
  }
}
