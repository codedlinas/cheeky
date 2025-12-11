import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../core/services/supabase_service.dart';
import '../models/message.dart';
import '../models/match.dart';
import '../models/profile.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(ref.watch(supabaseProvider));
});

class ChatRepository {
  final SupabaseClient _client;

  ChatRepository(this._client);

  Future<List<Match>> getMatches() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _client
        .from('matches')
        .select()
        .or('user_a.eq.$userId,user_b.eq.$userId')
        .order('created_at', ascending: false);

    final matches = <Match>[];
    for (final m in response as List) {
      final match = Match.fromJson(m);
      final otherUserId = match.userA == userId ? match.userB : match.userA;

      final profileResponse = await _client
          .from('profiles')
          .select()
          .eq('user_id', otherUserId)
          .maybeSingle();

      if (profileResponse != null) {
        final profile = Profile.fromJson(profileResponse);
        matches.add(match.copyWith(otherUser: profile));
      }
    }

    return matches;
  }

  Future<Match?> getMatch(String matchId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _client
        .from('matches')
        .select()
        .eq('id', matchId)
        .maybeSingle();

    if (response == null) return null;

    final match = Match.fromJson(response);
    final otherUserId = match.userA == userId ? match.userB : match.userA;

    final profileResponse = await _client
        .from('profiles')
        .select()
        .eq('user_id', otherUserId)
        .maybeSingle();

    if (profileResponse != null) {
      final profile = Profile.fromJson(profileResponse);
      return match.copyWith(otherUser: profile);
    }

    return match;
  }

  Future<List<Message>> getMessages(String matchId) async {
    final response = await _client
        .from('messages')
        .select()
        .eq('conversation_id', matchId)
        .order('created_at', ascending: true);

    return (response as List).map((m) => Message.fromJson(m)).toList();
  }

  Future<Message> sendMessage({
    required String matchId,
    required String content,
  }) async {
    final userId = _client.auth.currentUser!.id;

    final response = await _client
        .from('messages')
        .insert({
          'id': const Uuid().v4(),
          'conversation_id': matchId,
          'sender_id': userId,
          'content': content,
        })
        .select()
        .single();

    return Message.fromJson(response);
  }

  Stream<List<Message>> messagesStream(String matchId) {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', matchId)
        .order('created_at', ascending: true)
        .map((data) => data.map((m) => Message.fromJson(m)).toList());
  }
}

