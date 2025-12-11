import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../providers/swipe_provider.dart';
import '../widgets/swipe_card.dart';
import '../widgets/match_dialog.dart';

class SwipeScreen extends ConsumerStatefulWidget {
  const SwipeScreen({super.key});

  @override
  ConsumerState<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends ConsumerState<SwipeScreen> {
  final CardSwiperController _controller = CardSwiperController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final swipeState = ref.watch(swipeNotifierProvider);

    // Show match dialog when there's a new match
    ref.listen<SwipeState>(swipeNotifierProvider, (previous, next) {
      if (next.newMatch != null && previous?.newMatch != next.newMatch) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => MatchDialog(
            match: next.newMatch!,
            onDismiss: () {
              ref.read(swipeNotifierProvider.notifier).clearMatch();
              Navigator.of(context).pop();
            },
          ),
        );
      }
    });

    if (swipeState.isLoading && swipeState.candidates.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
      );
    }

    if (swipeState.candidates.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Discover'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 24),
              Text(
                'No more profiles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for new people',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  ref.read(swipeNotifierProvider.notifier).loadCandidates();
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: swipeState.candidates.length > 1 ? 2 : 1,
                  backCardOffset: const Offset(0, 40),
                  padding: EdgeInsets.zero,
                  onSwipe: (previousIndex, currentIndex, direction) {
                    final profile = swipeState.candidates[previousIndex];
                    final isLike = direction == CardSwiperDirection.right;

                    ref.read(swipeNotifierProvider.notifier).swipe(
                          targetUserId: profile.userId,
                          isLike: isLike,
                        );

                    return true;
                  },
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return SwipeCard(
                      profile: swipeState.candidates[index],
                      swipeProgress: percentThresholdX.toDouble(),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.close,
                    color: Colors.redAccent,
                    onPressed: () => _controller.swipe(CardSwiperDirection.left),
                  ),
                  _ActionButton(
                    icon: Icons.favorite,
                    color: AppTheme.primaryColor,
                    size: 72,
                    onPressed: () => _controller.swipe(CardSwiperDirection.right),
                  ),
                  _ActionButton(
                    icon: Icons.star,
                    color: Colors.amber,
                    onPressed: () => _controller.swipe(CardSwiperDirection.top),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: size * 0.5,
        ),
      ),
    );
  }
}

