// filepath: [book_provider.dart](http://_vscodecontentref_/1)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/book_model.dart';
import '../data/book_service.dart';

final bookServiceProvider = Provider<BookService>((ref) {
  return BookService(baseUrl: 'http://127.0.0.1:8000/api');
});

final bookProvider = StateNotifierProvider<BookController, List<BookModel>>((ref) {
  final service = ref.read(bookServiceProvider);
  return BookController(service);
});

class BookController extends StateNotifier<List<BookModel>> {
  final BookService _service;

  BookController(this._service) : super([]);

  Future<void> fetchAllBooks() async {
    final results = await _service.fetchAllBooks();
    state = results;
  }

  Future<void> fetchByCategory(String category) async {
    final results = await _service.fetchByCategory(category);
    state = results;
  }

  Future<void> searchBooks(String query) async {
    final results = await _service.searchBooks(query);
    state = results;
  }

  void clear() {
    state = [];
  }
}