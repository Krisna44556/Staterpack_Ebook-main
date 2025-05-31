import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/storage_helper.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;

  static Future<void> setAuthToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    await StorageHelper.saveToken(token);
  }

  static Future<void> clearAuthToken() async {
    _dio.options.headers.remove('Authorization');
    await StorageHelper.deleteToken();
  }

  static Future<void> initialize() async {
    final token = await StorageHelper.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // Method logout: panggil API logout, lalu clear token
  static Future<void> logout() async {
    try {
      await _dio.post('/logout');
    } catch (e) {
      // Abaikan error, misal token sudah expired
    } finally {
      await clearAuthToken();
    }
  }
}

// Riverpod provider untuk dio instance
final dioProvider = Provider<Dio>((ref) {
  return DioClient.dio;
});
