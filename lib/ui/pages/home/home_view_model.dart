// import 'package:flutter_book_app/data/model/book.dart';
// import 'package:flutter_book_app/data/repository/naver_book_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final bookSearchVM =
//     StateNotifierProvider.autoDispose<BookSearchVM, List<Book>?>(
//   (ref) => BookSearchVM(null),
// );

// class BookSearchVM extends StateNotifier<List<Book>?> {
//   BookSearchVM(super._state);

//   final naverBookRepo = NaverBookRepository();

//   Future<void> search(String query) async {
//     if (query.trim().isEmpty) {
//       return;
//     }
//     final result = await naverBookRepo.search(query);
//     state = result?.items ?? [];
//   }
// }
