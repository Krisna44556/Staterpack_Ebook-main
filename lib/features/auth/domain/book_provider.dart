import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../models/book_model.dart';
import '../data/book_service.dart';
import '../../../core/service/dio_client.dart';

final bookServiceProvider = Provider<BookService>((ref) {
  return BookService(dio: DioClient.dio);
});

final bookProvider = StateNotifierProvider<BookController, AsyncValue<List<BookModel>>>((ref) {
  final service = ref.read(bookServiceProvider);
  return BookController(service);
});

class BookController extends StateNotifier<AsyncValue<List<BookModel>>> {
  final BookService _service;

  BookController(this._service) : super(const AsyncValue.loading());

  Future<void> fetchAllBooks() async {
    state = const AsyncValue.loading();
    try {
      final results = await _service.fetchAllBooks();
      state = AsyncValue.data(results);
    } on DioException catch (e) {
      state = AsyncValue.error(
        e.response?.data['message'] ?? 'Failed to fetch books',
        StackTrace.current,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchByCategory(String category) async {
    state = const AsyncValue.loading();
    try {
      final results = await _service.fetchByCategory(category);
      state = AsyncValue.data(results);
    } on DioException catch (e) {
      state = AsyncValue.error(
        e.response?.data['message'] ?? 'Failed to fetch books by category',
        StackTrace.current,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchBooks(String query) async {
    state = const AsyncValue.loading();
    try {
      final results = await _service.searchBooks(query);
      state = AsyncValue.data(results);
    } on DioException catch (e) {
      state = AsyncValue.error(
        e.response?.data['message'] ?? 'Failed to search books',
        StackTrace.current,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
