import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../core/utils/storage_helper.dart';
import '../../../models/user_model.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });

final data = response.data['data']; // ambil dari key 'data'

if (data == null || data['user'] == null || data['token'] == null) {
  throw 'Login gagal: Data user atau token tidak ditemukan di respons API.';
}

await StorageHelper.saveToken(data['token']);
await DioClient.setAuthToken(data['token']);

return {
  'user': UserModel.fromJson(data['user']),
  'token': data['token'],
};

    } on DioException catch (e) {
      // Ambil pesan error dari backend jika ada
      throw e.response?.data['message'] ?? 'Login gagal';
    }
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
