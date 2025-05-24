// import 'package:dio/dio.dart';
// import '../../../core/constants/api_endpoints.dart';
// import 'package:sungokong_book/core/service/dio_client.dart';
// import '../../../core/utils/storage_helper.dart';
// import '../../../models/book_model.dart';

import 'package:dio/dio.dart';
import '../../../models/book_model.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/utils/storage_helper.dart';

class BookService {
  final Dio _dio;

  BookService({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // 📚 Ambil semua buku
  Future<List<BookModel>> fetchAllBooks() async {
    try {
      final response = await _dio.get('/public-books');
      print('✅ Response: ${response.data}'); // Tambahkan log ini
      final List data = response.data['data'];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  // 📖 Ambil detail buku berdasarkan ID
  Future<BookModel> fetchBookDetail(int id) async {
    try {
      final response = await _dio.get('/books/$id');
      final data = response.data['data'];
      return BookModel.fromJson(data);
    } catch (e) {
      throw Exception('Gagal mengambil detail buku: $e');
    }
  }

  // 📈 Ambil 10 buku terpopuler
  Future<List<BookModel>> fetchTopBooks() async {
    try {
      final response = await _dio.get('/books/top');
      final List data = response.data['data'];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil buku terpopuler: $e');
    }
  }

  // 📚 Ambil buku berdasarkan kategori
  Future<List<BookModel>> fetchByCategory(String category) async {
    try {
      final response = await _dio.get('/books/category/$category');
      final List data = response.data['data'];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil buku berdasarkan kategori: $e');
    }
  }

  // 🔍 Cari buku (hanya jika BE support search query param)
  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final response = await _dio.get('/books', queryParameters: {'search': query});
      final List data = response.data['data'];
      return data.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Gagal mencari buku: $e');
    }
  }
}

