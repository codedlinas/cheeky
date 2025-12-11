import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/profile.dart';
import '../../../common/models/match.dart';
import '../../../common/repositories/swipe_repository.dart';

final swipeCandidatesProvider = FutureProvider<List<Profile>>((ref) async {
  final repository = ref.watch(swipeRepositoryProvider);
  return repository.getSwipeCandidates();
});

final swipeNotifierProvider =
    StateNotifierProvider<SwipeNotifier, SwipeState>((ref) {
  return SwipeNotifier(ref.watch(swipeRepositoryProvider), ref);
});

class SwipeState {
  final List<Profile> candidates;
  final bool isLoading;
  final Match? newMatch;
  final String? error;

  SwipeState({
    this.candidates = const [],
    this.isLoading = false,
    this.newMatch,
    this.error,
  });

  SwipeState copyWith({
    List<Profile>? candidates,
    bool? isLoading,
    Match? newMatch,
    String? error,
    bool clearMatch = false,
  }) {
    return SwipeState(
      candidates: candidates ?? this.candidates,
      isLoading: isLoading ?? this.isLoading,
      newMatch: clearMatch ? null : (newMatch ?? this.newMatch),
      error: error,
    );
  }
}

class SwipeNotifier extends StateNotifier<SwipeState> {
  final SwipeRepository _repository;
  final Ref _ref;

  SwipeNotifier(this._repository, this._ref) : super(SwipeState()) {
    loadCandidates();
  }

  Future<void> loadCandidates() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final candidates = await _repository.getSwipeCandidates();
      state = state.copyWith(candidates: candidates, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> swipe({required String targetUserId, required bool isLike}) async {
    try {
      final match = await _repository.recordSwipe(
        targetUserId: targetUserId,
        isLike: isLike,
      );

      if (match != null) {
        state = state.copyWith(newMatch: match);
      }

      // Remove the swiped profile from candidates
      final updatedCandidates = state.candidates
          .where((p) => p.userId != targetUserId)
          .toList();
      state = state.copyWith(candidates: updatedCandidates);

      // Reload if running low on candidates
      if (updatedCandidates.length < 3) {
        loadCandidates();
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void clearMatch() {
    state = state.copyWith(clearMatch: true);
  }
}

