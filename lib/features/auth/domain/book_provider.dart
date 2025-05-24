import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/book_model.dart';
import '../data/book_service.dart';

/// Provider untuk BookService (opsional tapi disarankan)
final bookServiceProvider = Provider<BookService>((ref) {
  return BookService(baseUrl: 'http://localhost:8000/api/public-books');
});

/// StateNotifierProvider untuk daftar buku
final bookProvider = StateNotifierProvider<BookController, List<BookModel>>((ref) {
  final service = ref.read(bookServiceProvider);
  return BookController(service);
});

/// BookController dengan dependency injection ke BookService
class BookController extends StateNotifier<List<BookModel>> {
  final BookService _service;

  BookController(this._service) : super([]);

  Future<void> searchBooks(String query) async {
    final results = await _service.searchBooks(query);
    state = results;
  }

  Future<void> fetchByCategory(String category) async {
    print('Fetching category: $category'); // 👈 log
    final results = await _service.fetchByCategory(category);
    print('Result count: ${results.length}'); // 👈 log
    state = results;
  }

  void clear() {
    state = [];
  }
}
