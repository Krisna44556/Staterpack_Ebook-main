import 'package:dio/dio.dart';
import '../../../core/service/dio_client.dart'; // Assuming you have this
import '../../../core/utils/storage_helper.dart'; // For token handling
import '../../../models/book_model.dart';

class BookService {
  final Dio _dio;

  BookService({required Dio dio}) : _dio = dio;

  // Helper method to add auth header
  Future<void> _addAuthorizationHeader() async {
    final token = await StorageHelper.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<BookModel>> fetchAllBooks() async {
    try {
      final response = await _dio.get('/public-books');
      final List data = response.data['data'] ?? [];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch books';
    }
  }

  // 🔥 Get top 10 popular books (protected)
  Future<List<BookModel>> fetchTopBooks() async {
    await _addAuthorizationHeader();
    final response = await _dio.get('/books/top');
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  // 🏷️ Get books by category (protected)
  Future<List<BookModel>> fetchByCategory(String category) async {
    try {
      final response = await _dio.get('/books/category/$category');
      final List data = response.data['data'] ?? [];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch books by category';
    }
  }

  // 📖 Get book details (protected)
  Future<BookModel> fetchBookDetail(int id) async {
    await _addAuthorizationHeader();
    final response = await _dio.get('/books/$id');
    final data = response.data['data'];
    return BookModel.fromJson(data);
  }

  // 🔍 Search books (protected)
  Future<List<BookModel>> searchBooks(String query) async {
    await _addAuthorizationHeader();
    final response =
        await _dio.get('/books', queryParameters: {'search': query});
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }
}
