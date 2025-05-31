import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../data/auth_repository.dart';

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository = AuthRepository();

  AuthNotifier() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _authRepository.getMe();
      state = user;
    } catch (_) {
      state = null;
    }
  }

  /// Login dengan email & password
  /// Return true jika berhasil, false jika gagal
  Future<bool> login(String email, String password) async {
    try {
      final result = await _authRepository.login(email, password);
      if (result.containsKey('user') && result['user'] != null) {
        state = result['user'] as UserModel;
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Register dengan nama, email, password dan konfirmasi password
  /// Return true jika berhasil, false jika gagal
  Future<bool> register(String name, String email, String password, String confirmPassword) async {
    try {
      final result = await _authRepository.register(name, email, password, confirmPassword);
      if (result.containsKey('user') && result['user'] != null) {
        state = result['user'] as UserModel;
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } finally {
      state = null;
    }
  }
}
