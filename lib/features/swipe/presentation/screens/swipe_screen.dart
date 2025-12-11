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
    final texts = getSwipeScreenTexts(variant);
    final appBarStyle = getAppBarStyle(variant);
    final cardPadding = getCardPadding(variant);

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
          child: _buildLoadingIndicator(variant, primaryColor),
        ),
      );
    }

    if (swipeState.candidates.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(context, variant, texts.title, appBarStyle),
        body: _buildEmptyState(context, variant, texts, primaryColor, ref),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context, variant, texts.title, appBarStyle),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: cardPadding,
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: swipeState.candidates.length > 1 ? 2 : 1,
                  backCardOffset: _getBackCardOffset(variant),
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
            _buildActionButtons(context, variant, texts),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppThemeVariant variant,
    String title,
    AppBarStyle style,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return AppBar(
          title: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00FF00),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00FF00),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  letterSpacing: 4,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        return AppBar(
          title: Text(
            title,
            style: const TextStyle(
              letterSpacing: 6,
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      case AppThemeVariant.v6PlayfulPastel:
        return AppBar(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6B9D),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      case AppThemeVariant.v7HighContrastRed:
        return AppBar(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      default:
        return AppBar(
          title: Text(
            title,
            style: style.titleStyle,
          ),
          centerTitle: style.centerTitle,
          elevation: style.elevation,
        );
    }
  }

  Widget _buildLoadingIndicator(AppThemeVariant variant, Color primaryColor) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SCANNING...',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                fontSize: 14,
                letterSpacing: 4,
                fontFamily: 'monospace',
              ),
            ),
          ],
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Finding friends... 💫',
              style: TextStyle(
                color: Color(0xFFFF6B9D),
                fontSize: 16,
              ),
            ),
          ],
        );
      default:
        return CircularProgressIndicator(color: primaryColor);
    }
  }

  Widget _buildEmptyState(
    BuildContext context,
    AppThemeVariant variant,
    SwipeScreenTexts texts,
    Color primaryColor,
    WidgetRef ref,
  ) {
    final icon = getEmptyStateIcon(variant);
    final isDark = isThemeDark(variant);

    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFFF), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FFFF).withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(icon, size: 60, color: const Color(0xFF00FFFF)),
              ),
              const SizedBox(height: 30),
              Text(
                texts.emptyTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FFFF),
                  letterSpacing: 4,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                texts.emptySubtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  letterSpacing: 2,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => ref.read(swipeNotifierProvider.notifier).loadCandidates(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFF00FF), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF00FF).withValues(alpha: 0.4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Text(
                    texts.refreshText,
                    style: const TextStyle(
                      color: Color(0xFFFF00FF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B9D).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 60, color: const Color(0xFFFF6B9D)),
              ),
              const SizedBox(height: 24),
              Text(
                texts.emptyTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B9D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                texts.emptySubtitle,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => ref.read(swipeNotifierProvider.notifier).loadCandidates(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B9D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(texts.refreshText),
              ),
            ],
          ),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: primaryColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                texts.emptyTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                texts.emptySubtitle,
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => ref.read(swipeNotifierProvider.notifier).loadCandidates(),
                child: Text(texts.refreshText),
              ),
            ],
          ),
        );
    }
  }

  Offset _getBackCardOffset(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v2ModernGlassblur:
        return const Offset(0, 50);
      case AppThemeVariant.v4MinimalSoft:
        return const Offset(0, 20);
      case AppThemeVariant.v10CardStack3D:
        return const Offset(0, 60);
      default:
        return const Offset(0, 40);
    }
  }

  Widget _buildActionButtons(BuildContext context, AppThemeVariant variant, SwipeScreenTexts texts) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonButtons(context, texts);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryButtons(context, texts);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelButtons(context, texts);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldButtons(context, texts);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleButtons(context, texts);
      default:
        return _buildDefaultButtons(context, variant, texts);
    }
  }

  Widget _buildDefaultButtons(BuildContext context, AppThemeVariant variant, SwipeScreenTexts texts) {
    final primaryColor = getThemePrimaryColor(variant);
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

  Widget _buildNeonButtons(BuildContext context, SwipeScreenTexts texts) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NeonButton(
            icon: Icons.close,
            color: const Color(0xFFFF00FF),
            label: texts.nopeText.replaceAll(' ', ''),
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _NeonButton(
            icon: Icons.favorite,
            color: const Color(0xFF00FFFF),
            label: texts.likeText.replaceAll(' ', ''),
            size: 72,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _NeonButton(
            icon: Icons.bolt,
            color: const Color(0xFFFFFF00),
            label: texts.superLikeText.replaceAll(' ', ''),
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryButtons(BuildContext context, SwipeScreenTexts texts) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _LuxuryButton(
            icon: Icons.close,
            label: texts.nopeText,
            onPressed: () => _controller.swipe(CardSwiperDirection.left),
          ),
          _LuxuryButton(
            icon: Icons.diamond,
            label: texts.likeText,
            isPrimary: true,
            size: 72,
            onPressed: () => _controller.swipe(CardSwiperDirection.right),
          ),
          _LuxuryButton(
            icon: Icons.star,
            label: texts.superLikeText,
            onPressed: () => _controller.swipe(CardSwiperDirection.top),
          ),
        ],
      ),
    );
  }

  Widget _buildPastelButtons(BuildContext context, SwipeScreenTexts texts) {
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

  Widget _buildBoldButtons(BuildContext context, SwipeScreenTexts texts) {
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

  Widget _buildBubbleButtons(BuildContext context, SwipeScreenTexts texts) {
    const primaryColor = Color(0xFF00CEC9);
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
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
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
    const goldColor = Color(0xFFD4AF37);
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
              fontSize: 9,
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
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
