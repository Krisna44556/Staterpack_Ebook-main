import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/profile_repository.dart';
import '../../../models/user_model.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileProvider = FutureProvider<UserModel>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.fetchProfile();
});

final updateProfileProvider = FutureProvider.family<UserModel, Map<String, dynamic>>((ref, data) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.updateProfile(data);
});
