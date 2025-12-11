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

    // Get current user's profile to know their preferences
    final myProfileResponse = await _client
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    // Get IDs of users already swiped
    List<String> swipedIds = [];
    try {
      final swipedResponse = await _client
          .from('swipes')
          .select('target_id')
          .eq('swiper_id', userId);

      swipedIds = (swipedResponse as List)
          .map((s) => s['target_id'] as String)
          .toList();
    } catch (e) {
      // Ignore swipes errors for now
    }
    swipedIds.add(userId); // Exclude self

    // Get all profiles (show all for testing, can filter by preference later)
    var query = _client.from('profiles').select();

    // If user has profile, optionally filter by preference
    if (myProfileResponse != null) {
      final myProfile = Profile.fromJson(myProfileResponse);
      query = _client
          .from('profiles')
          .select()
          .eq('gender', myProfile.interestedIn);
    }

    // Filter out already swiped profiles and self
    if (swipedIds.isNotEmpty) {
      query = query.not('user_id', 'in', swipedIds);
    }

    final response = await query.limit(20);

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

