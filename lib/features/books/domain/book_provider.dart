import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/service/dio_client.dart';
import '../data/book_repository.dart';
import '../../../models/book_model.dart';

/// Provider global untuk Dio instance
final dioProvider = Provider((ref) => DioClient.dio);

/// Provider BookRepository
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return BookRepository(dio: dio);
});

/// Provider list buku publik (tidak autoDispose agar cache data tetap ada saat berpindah halaman)
final publicBooksProvider = FutureProvider<List<BookModel>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.fetchPublicBooks();
});

/// Provider list buku top/populer
final topBooksProvider = FutureProvider<List<BookModel>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.fetchTopBooks();
});

/// Provider list buku berdasarkan kategori tertentu
final booksByCategoryProvider = FutureProvider.family<List<BookModel>, int>((ref, categoryId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.fetchBooksByCategory(categoryId);
});

/// Provider detail buku berdasarkan ID
final bookDetailProvider = FutureProvider.family<BookModel, int>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.fetchBookDetail(bookId);
});
