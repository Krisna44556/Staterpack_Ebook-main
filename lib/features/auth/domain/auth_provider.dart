import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../../../models/user_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _repo = AuthRepository();

  AuthNotifier() : super(null);

  Future<void> login(String email, String password) async {
    final result = await _repo.login(email, password);
    state = result['user'];
  }

  Future<void> register(String name, String email, String password, String passwordConfirmation) async {
    final result = await _repo.register(name, email, password, passwordConfirmation);
    state = result['user'];
  }

  void logout() {
    state = null;
    _repo.logout();
  }
}