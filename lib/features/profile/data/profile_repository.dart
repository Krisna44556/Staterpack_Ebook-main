import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../models/user_model.dart';

class ProfileRepository {
  final Dio _dio = DioClient.dio;

  Future<UserModel> fetchProfile() async {
    final response = await _dio.get(ApiEndpoints.profile);
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await _dio.put(ApiEndpoints.profile, data: data);
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to update profile');
    }
  }
}
