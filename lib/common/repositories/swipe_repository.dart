import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/services/supabase_service.dart';
import '../models/profile.dart';
import '../models/match.dart';

final swipeRepositoryProvider = Provider<SwipeRepository>((ref) {
  return SwipeRepository(ref.watch(supabaseProvider));
});

class SwipeRepository {
  final SupabaseClient _client;

  SwipeRepository(this._client);

  Future<List<Profile>> getSwipeCandidates() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    // Get IDs of users already swiped
    List<String> swipedIds = [userId]; // Start with self excluded
    try {
      final swipedResponse = await _client
          .from('swipes')
          .select('target_id')
          .eq('swiper_id', userId);

      swipedIds.addAll(
        (swipedResponse as List).map((s) => s['target_id'] as String),
      );
    } catch (e) {
      // Ignore swipes errors for now
    }

    // Get ALL profiles (no gender filter for testing)
    // This shows all 20+ profiles you added to Supabase
    final response = await _client
        .from('profiles')
        .select()
        .not('user_id', 'in', swipedIds)
        .limit(50);

    return (response as List).map((p) => Profile.fromJson(p)).toList();
  }

  Future<Match?> recordSwipe({
    required String targetUserId,
    required bool isLike,
  }) async {
    final userId = _client.auth.currentUser!.id;

    // Record the swipe
    await _client.from('swipes').insert({
      'id': const Uuid().v4(),
      'swiper_id': userId,
      'target_id': targetUserId,
      'is_like': isLike,
    });

    // If it's a like, check for mutual match
    if (isLike) {
      final mutualSwipe = await _client
          .from('swipes')
          .select()
          .eq('swiper_id', targetUserId)
          .eq('target_id', userId)
          .eq('is_like', true)
          .maybeSingle();

      if (mutualSwipe != null) {
        // Create a match!
        final matchId = const Uuid().v4();
        await _client.from('matches').insert({
          'id': matchId,
          'user_a': userId,
          'user_b': targetUserId,
        });

        // Get the other user's profile
        final otherProfileResponse = await _client
            .from('profiles')
            .select()
            .eq('user_id', targetUserId)
            .single();

        final otherProfile = Profile.fromJson(otherProfileResponse);

        // Fetch the created match
        final matchResponse = await _client
            .from('matches')
            .select()
            .eq('id', matchId)
            .single();

        return Match.fromJson(matchResponse, otherUser: otherProfile);
      }
    }

    return null;
  }
}

