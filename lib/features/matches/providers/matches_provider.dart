import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/match.dart';
import '../../../common/models/message.dart';
import '../../../common/repositories/chat_repository.dart';

final matchesProvider = FutureProvider<List<Match>>((ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMatches();
});

final matchProvider = FutureProvider.family<Match?, String>((ref, matchId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMatch(matchId);
});

final messagesProvider =
    FutureProvider.family<List<Message>, String>((ref, matchId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMessages(matchId);
});

final messagesStreamProvider =
    StreamProvider.family<List<Message>, String>((ref, matchId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.messagesStream(matchId);
});

final chatNotifierProvider =
    StateNotifierProvider.family<ChatNotifier, AsyncValue<void>, String>(
        (ref, matchId) {
  return ChatNotifier(ref.watch(chatRepositoryProvider), matchId);
});

class ChatNotifier extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _repository;
  final String matchId;

  ChatNotifier(this._repository, this.matchId) : super(const AsyncValue.data(null));

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    state = const AsyncValue.loading();
    try {
      await _repository.sendMessage(
        matchId: matchId,
        content: content.trim(),
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

