import '../../../models/category_model.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final Dio _dio = DioClient.dio;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get(ApiEndpoints.categories);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioError catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
