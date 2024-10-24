import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final writeViewModel = NotifierProvider.family
    .autoDispose<WriteViewModel, WritePageState, Post?>(WriteViewModel.new);

class WritePageState {
  const WritePageState(
    this.isWriting,
    this.imageUrl,
  );
  final bool isWriting;
  final String? imageUrl;
}

class WriteViewModel extends AutoDisposeFamilyNotifier<WritePageState, Post?> {
  final postRepository = const PostRepository();

  @override
  WritePageState build(Post? arg) {
    return WritePageState(false, arg?.imgUrl);
  }

  String? validateWriter(String? v) {
    if (v?.trim().isEmpty ?? true) {
      return '작성자를 입력해 주세요';
    }
    return null;
  }

  String? validateTitle(String? v) {
    if (v?.trim().isEmpty ?? true) {
      return '제목을 입력해 주세요';
    }
    return null;
  }

  String? validateContent(String? v) {
    if (v?.trim().isEmpty ?? true) {
      return '컨텐츠를 입력해 주세요';
    }
    return null;
  }

  Future<void> uploadImage(XFile? xFile) async {
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
    if (arg?.content == content &&
        arg?.title == title &&
        writer == arg?.writer &&
        arg?.imgUrl == state.imageUrl) {
      return false;
    }
    state = WritePageState(true, state.imageUrl);

    final result = arg == null
        ? await postRepository.insert(
            writer: writer,
            title: title,
            content: content,
            imageUrl: state.imageUrl!)
        : await postRepository.update(
            id: arg!.id,
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
