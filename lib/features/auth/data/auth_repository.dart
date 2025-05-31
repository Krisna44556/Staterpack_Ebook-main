import 'package:dio/dio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/service/dio_client.dart';
import '../../../core/utils/storage_helper.dart';
import '../../../models/user_model.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;

  /// Login user dan simpan token
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });

      final data = response.data['data'];

      if (data == null || data['user'] == null || data['token'] == null) {
        throw 'Login gagal: data user/token tidak ditemukan di response.';
      }

      final token = data['token'];
      final user = UserModel.fromJson(data['user']);

      await StorageHelper.saveToken(token);
      await DioClient.setAuthToken(token);

      return {'user': user, 'token': token};
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Login gagal';
      throw message;
    }
  }

  /// Register user baru
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await _dio.post(ApiEndpoints.register, data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      final data = response.data['data'];

      if (data == null || data['user'] == null || data['token'] == null) {
        throw 'Register gagal: data user/token tidak ditemukan di response.';
      }

      final token = data['token'];
      final user = UserModel.fromJson(data['user']);

      await StorageHelper.saveToken(token);
      await DioClient.setAuthToken(token);

      return {'user': user, 'token': token};
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Register gagal';
      throw message;
    }
  }

  /// Ambil data user dari endpoint /api/me
  Future<UserModel> getMe() async {
    final token = await StorageHelper.getToken();

    if (token == null) throw 'Token tidak ditemukan. Silakan login ulang.';

    await DioClient.setAuthToken(token);

    try {
      final response = await _dio.get(ApiEndpoints.me);
      final userData = response.data['data'];
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Gagal mengambil data user';
      throw message;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _dio.post(ApiEndpoints.logout);
    } catch (_) {
      // Biarkan jika gagal, kita tetap lanjut hapus token
    }

    await StorageHelper.deleteToken();
    await DioClient.clearAuthToken();
  }
}
