import 'package:dio/dio.dart';
import '../utils/storage_helper.dart'; // pastikan path sesuai dengan project Anda

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api', // gunakan 127.0.0.1 jika run di browser, gunakan 10.0.2.2 untuk Android emulator
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;

  /// Digunakan saat login sukses (setelah dapat token)
  static Future<void> setAuthToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    await StorageHelper.saveToken(token);
  }

  /// Digunakan saat logout
  static Future<void> clearAuthToken() async {
    _dio.options.headers.remove('Authorization');
    await StorageHelper.deleteToken();
  }

  /// Panggil saat startup aplikasi agar langsung set token jika tersedia
  static Future<void> initialize() async {
    final token = await StorageHelper.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      }
      }
}