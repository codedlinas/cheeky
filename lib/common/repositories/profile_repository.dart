import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/services/supabase_service.dart';
import '../models/profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(supabaseProvider));
});

class ProfileRepository {
  final SupabaseClient _client;

  ProfileRepository(this._client);

  Future<Profile?> getCurrentUserProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _client
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Profile.fromJson(response);
  }

  Future<Profile?> getProfileByUserId(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Profile.fromJson(response);
  }

  Future<Profile> createOrUpdateProfile({
    required String displayName,
    String? bio,
    required String gender,
    required String interestedIn,
    required int age,
    String? photoUrl,
  }) async {
    final userId = _client.auth.currentUser!.id;

    final existingProfile = await getCurrentUserProfile();

    if (existingProfile != null) {
      final response = await _client
          .from('profiles')
          .update({
            'display_name': displayName,
            'bio': bio,
            'gender': gender,
            'interested_in': interestedIn,
            'age': age,
            'photo_url': photoUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('user_id', userId)
          .select()
          .single();

      return Profile.fromJson(response);
    } else {
      final response = await _client
          .from('profiles')
          .insert({
            'id': const Uuid().v4(),
            'user_id': userId,
            'display_name': displayName,
            'bio': bio,
            'gender': gender,
            'interested_in': interestedIn,
            'age': age,
            'photo_url': photoUrl,
          })
          .select()
          .single();

      return Profile.fromJson(response);
    }
  }

  Future<String> uploadProfilePhoto(Uint8List imageBytes, String fileName) async {
    final userId = _client.auth.currentUser!.id;
    final filePath = '$userId/$fileName';

    await _client.storage.from('profile_photos').uploadBinary(
          filePath,
          imageBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    final publicUrl =
        _client.storage.from('profile_photos').getPublicUrl(filePath);

    return publicUrl;
  }
}

