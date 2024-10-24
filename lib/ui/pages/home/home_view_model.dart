import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> fetchData() async {
    state = await postRepository.getAll();
  }
}
