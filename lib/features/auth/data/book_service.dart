// filepath: [book_service.dart](http://_vscodecontentref_/0)
import 'package:dio/dio.dart';
import '../../../models/book_model.dart';

class BookService {
  final Dio _dio;

  BookService({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // 📚 Ambil semua buku
  Future<List<BookModel>> fetchAllBooks() async {
    final response = await _dio.get('/public-books');
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  // � Ambil 10 buku terpopuler
  Future<List<BookModel>> fetchTopBooks() async {
    final response = await _dio.get('/books/top');
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  // � Ambil buku berdasarkan kategori
  Future<List<BookModel>> fetchByCategory(String category) async {
    final response = await _dio.get('/books/category/$category');
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }

  // � Ambil detail buku berdasarkan ID
  Future<BookModel> fetchBookDetail(int id) async {
    final response = await _dio.get('/books/$id');
    final data = response.data['data'];
    return BookModel.fromJson(data);
  }

  // 🔍 Cari buku (hanya jika BE support search query param)
  Future<List<BookModel>> searchBooks(String query) async {
    final response = await _dio.get('/books', queryParameters: {'search': query});
    final List data = response.data['data'];
    return data.map((e) => BookModel.fromJson(e)).toList();
  }
}