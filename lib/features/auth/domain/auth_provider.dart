import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../data/auth_repository.dart';

final authProvider = StateNotifierProvider<AuthController, UserModel?>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _repository = AuthRepository();

  AuthController() : super(null);

  Future<void> login(String email, String password) async {
    final result = await _repository.login(email, password);
    state = result['user'];
  }

  Future<void> register(String name, String email, String password, String passwordConfirmation) async {
    final result = await _repository.register(name, email, password, passwordConfirmation);
    state = result['user'];
  }

  Future<void> loadUser() async {
    state = await _repository.getMe();
  }

  Future<void> logout() async {
    await _repository.logout();
    state = null;
  }
}
