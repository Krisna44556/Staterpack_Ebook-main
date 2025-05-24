import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:sungokong_book/core/service/dio_client.dart';
import '../../../core/utils/storage_helper.dart';
import '../../../models/user_model.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await DioClient.dio.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
  
    final token = response.data['data']['token'];
    final user = UserModel.fromJson(response.data['data']['user']);
    await StorageHelper.saveToken(token);
    await DioClient.setAuthToken(token);

    return {'user': user, 'token': token};
  }

  Future<Map<String, dynamic>> register(String name, String email, String password, String passwordConfirmation) async {
    final response = await DioClient.dio.post(ApiEndpoints.register, data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    final token = response.data['data']['token'];
    final user = UserModel.fromJson(response.data['data']['user']);
    await StorageHelper.saveToken(token);
    await DioClient.setAuthToken(token);

    return {'user': user, 'token': token};
  }

  Future<UserModel> getMe() async {
    final token = await StorageHelper.getToken();
    if (token != null) await DioClient.setAuthToken(token);

    final response = await DioClient.dio.get(ApiEndpoints.me);
    return UserModel.fromJson(response.data['data']);
  }

  Future<void> logout() async {
    await StorageHelper.clearToken();
    await DioClient.clearAuthToken();
  }
}
