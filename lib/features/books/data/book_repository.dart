import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../models/book_model.dart';

class BookRepository {
  final Dio dio;

  BookRepository({Dio? dio}) : dio = dio ?? DioClient.dio;

  Future<List<BookModel>> fetchPublicBooks() async {
    final response = await dio.get(ApiEndpoints.publicBooks);
    if (response.statusCode == 200) {
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load public books');
    }
  }

  Future<List<BookModel>> fetchTopBooks() async {
    final response = await dio.get(ApiEndpoints.topBooks);
    if (response.statusCode == 200) {
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top books');
    }
  }

  Future<List<BookModel>> fetchBooksByCategory(int categoryId) async {
    final response = await dio.get('${ApiEndpoints.bookByCategory}/$categoryId');
    if (response.statusCode == 200) {
      final List data = response.data['data'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books by category');
    }
  }

  Future<BookModel> fetchBookDetail(int id) async {
    final response = await dio.get('${ApiEndpoints.bookDetail}/$id');
    if (response.statusCode == 200) {
      final data = response.data['data'] as Map<String, dynamic>;
      return BookModel.fromJson(data);
    } else {
      throw Exception('Failed to load book detail');
    }
  }
}
