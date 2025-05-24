// import 'package:dio/dio.dart';

// class DioClient {
//   static final Dio _dio = Dio(BaseOptions(
//     baseUrl: 'http://10.0.2.2:8000/api', // sesuaikan jika bukan emulator Android
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//     headers: {
//       'Accept': 'application/json',
//     },
//   ));

//   static Dio get dio => _dio;

//   static Future<void> setAuthToken(String token) async {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   static Future<void> clearAuthToken() async {
//     _dio.options.headers.remove('Authorization');
//   }

//   final token = await StorageHelper.getToken();
//     if (token != null) {
//   await DioClient.setAuthToken(token);
// }

// }

import 'package:dio/dio.dart';
import '../utils/storage_helper.dart'; // pastikan import ini bener

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8000/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
    },
  ));

  static Dio get dio => _dio;

  /// Panggil ini saat awal aplikasi
  static Future<void> initAuth() async {
    final token = await StorageHelper.getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<void> setAuthToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<void> clearAuthToken() async {
    _dio.options.headers.remove('Authorization');
  }
}
