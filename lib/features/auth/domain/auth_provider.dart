import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../../../models/user_model.dart';
import 'dart:convert'; // untuk jsonEncode & jsonDecode
import 'package:http/http.dart' as http; // untuk http.post, http.get, dll


final authProvider = StateNotifierProvider<AuthNotifier, Map<String, dynamic>?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<Map<String, dynamic>?> {
  AuthNotifier() : super(null);

  final String baseUrl = 'http://127.0.0.1:8000/api'; // Ganti IP sesuai emulator/device

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      state = data['data'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Login gagal');
    }
  }

  Future<void> register(String name, String email, String password, String confirmPassword) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    }),
  );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        state = data['data'];
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Pendaftaran gagal');
      }
    }

}