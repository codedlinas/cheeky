import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/profile.dart';
import '../../../common/repositories/profile_repository.dart';

final currentProfileProvider = FutureProvider<Profile?>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getCurrentUserProfile();
});

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>((ref) {
  return ProfileNotifier(ref.watch(profileRepositoryProvider));
});

class ProfileNotifier extends StateNotifier<AsyncValue<Profile?>> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final profile = await _repository.getCurrentUserProfile();
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfile({
    required String displayName,
    String? bio,
    required String gender,
    required String interestedIn,
    required int age,
    String? photoUrl,
  }) async {
    try {
      final profile = await _repository.createOrUpdateProfile(
        displayName: displayName,
        bio: bio,
        gender: gender,
        interestedIn: interestedIn,
        age: age,
        photoUrl: photoUrl,
      );
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

