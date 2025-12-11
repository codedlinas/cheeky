import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme_provider.dart';
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
    final variant = ref.watch(themeVariantProvider);
    final primaryColor = getThemePrimaryColor(variant);

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
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    if (swipeState.candidates.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_getTitleForVariant(variant)),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getEmptyIconForVariant(variant),
                size: 80,
                color: primaryColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                _getEmptyTitleForVariant(variant),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getEmptySubtitleForVariant(variant),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  ref.read(swipeNotifierProvider.notifier).loadCandidates();
                },
                child: Text(_getRefreshTextForVariant(variant)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleForVariant(variant)),
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
            _buildActionButtons(context, variant),
          ],
        ),
      ),
    );
  }

  String _getTitleForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return 'SCAN';
      case AppThemeVariant.v5LuxuryGoldBlack:
        return 'CURATED';
      case AppThemeVariant.v6PlayfulPastel:
        return 'Find Friends! 💫';
      case AppThemeVariant.v7HighContrastRed:
        return 'SWIPE!';
      case AppThemeVariant.v8BlueCorporate:
        return 'Connect';
      default:
        return 'Discover';
    }
  }

  IconData _getEmptyIconForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Icons.wifi_tethering_off;
      case AppThemeVariant.v6PlayfulPastel:
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.search_off;
    }
  }

  String _getEmptyTitleForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return 'NO SIGNAL';
      case AppThemeVariant.v5LuxuryGoldBlack:
        return 'No Selections Available';
      case AppThemeVariant.v6PlayfulPastel:
        return 'No one here yet 😢';
      default:
        return 'No more profiles';
    }
  }

  String _getEmptySubtitleForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return 'Scanning for new connections...';
      case AppThemeVariant.v5LuxuryGoldBlack:
        return 'Our curators are finding matches for you';
      case AppThemeVariant.v6PlayfulPastel:
        return 'Come back later for more friends!';
      default:
        return 'Check back later for new people';
    }
  }

  String _getRefreshTextForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return 'RESCAN';
      case AppThemeVariant.v5LuxuryGoldBlack:
        return 'REFRESH';
      case AppThemeVariant.v6PlayfulPastel:
        return 'Try Again! 🔄';
      default:
        return 'Refresh';
    }
  }

  Widget _buildActionButtons(BuildContext context, AppThemeVariant variant) {
    final primaryColor = getThemePrimaryColor(variant);
    final buttonRadius = getButtonBorderRadius(variant);

    // Different button layouts per variant
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonButtons(context, primaryColor);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryButtons(context);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelButtons(context);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldButtons(context);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleButtons(context, primaryColor);
      default:
        return _buildDefaultButtons(context, primaryColor, buttonRadius);
    }
  }

  Widget _buildDefaultButtons(BuildContext context, Color primaryColor, double radius) {
    return Padding(
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
            color: primaryColor,
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
    );
  }

  Widget _buildNeonButtons(BuildContext context, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NeonButton(
            icon: Icons.close,
            color: const Color(0xFFFF00FF),
            label: 'SKIP',
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _NeonButton(
            icon: Icons.favorite,
            color: const Color(0xFF00FFFF),
            label: 'MATCH',
            size: 72,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _NeonButton(
            icon: Icons.bolt,
            color: const Color(0xFFFFFF00),
            label: 'BOOST',
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _LuxuryButton(
            icon: Icons.close,
            label: 'PASS',
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _LuxuryButton(
            icon: Icons.diamond,
            label: 'SELECT',
            isPrimary: true,
            size: 72,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _LuxuryButton(
            icon: Icons.star,
            label: 'VIP',
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildPastelButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _PastelButton(
            emoji: '👎',
            color: const Color(0xFF74B9FF),
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _PastelButton(
            emoji: '💕',
            color: const Color(0xFFFF6B9D),
            size: 80,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _PastelButton(
            emoji: '⭐',
            color: const Color(0xFFFECA57),
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildBoldButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BoldButton(
            icon: Icons.close,
            color: Colors.white,
            bgColor: Colors.black,
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _BoldButton(
            icon: Icons.favorite,
            color: Colors.white,
            bgColor: Colors.red,
            size: 80,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _BoldButton(
            icon: Icons.local_fire_department,
            color: Colors.black,
            bgColor: Colors.white,
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleButtons(BuildContext context, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BubbleButton(
            icon: Icons.close,
            color: const Color(0xFFFF7675),
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _BubbleButton(
            icon: Icons.favorite,
            color: primaryColor,
            size: 80,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _BubbleButton(
            icon: Icons.auto_awesome,
            color: const Color(0xFFFDCB6E),
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }
}

// Default action button
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
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}

// Neon cyberpunk button
class _NeonButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;
  final double size;

  const _NeonButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: color, size: size * 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

// Luxury gold button
class _LuxuryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double size;

  const _LuxuryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final goldColor = const Color(0xFFD4AF37);
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isPrimary ? goldColor : Colors.black,
              border: Border.all(color: goldColor, width: isPrimary ? 2 : 1),
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.black : goldColor,
              size: size * 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: goldColor,
              fontSize: 10,
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }
}

// Pastel kawaii button
class _PastelButton extends StatelessWidget {
  final String emoji;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  const _PastelButton({
    required this.emoji,
    required this.color,
    required this.onPressed,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 3),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: size * 0.4),
          ),
        ),
      ),
    );
  }
}

// Bold high contrast button
class _BoldButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onPressed;
  final double size;

  const _BoldButton({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onPressed,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: color, width: 4),
        ),
        child: Icon(icon, color: color, size: size * 0.6),
      ),
    );
  }
}

// Bubble rounded button
class _BubbleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double size;

  const _BubbleButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.8),
              color,
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
