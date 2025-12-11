import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../common/models/profile.dart';
import '../../providers/swipe_provider.dart';
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
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }

    if (swipeState.candidates.isEmpty) {
      return _buildEmptyState(context, variant, primaryColor, ref);
    }

    // Each variant has a COMPLETELY DIFFERENT layout
    switch (variant) {
      case AppThemeVariant.v1ClassicTinder:
        return _buildClassicLayout(context, swipeState, variant);
      case AppThemeVariant.v2ModernGlassblur:
        return _buildFullScreenGlassLayout(context, swipeState, variant);
      case AppThemeVariant.v3DarkNeon:
        return _buildCyberpunkHUDLayout(context, swipeState, variant);
      case AppThemeVariant.v4MinimalSoft:
        return _buildMinimalCleanLayout(context, swipeState, variant);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryMagazineLayout(context, swipeState, variant);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildKawaiiCardLayout(context, swipeState, variant);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBrutalistLayout(context, swipeState, variant);
      case AppThemeVariant.v8BlueCorporate:
        return _buildCorporateProfileLayout(context, swipeState, variant);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleStackLayout(context, swipeState, variant);
      case AppThemeVariant.v10CardStack3D:
        return _buildSpaceGalaxyLayout(context, swipeState, variant);
    }
  }

  // ============================================
  // V1: CLASSIC TINDER - Standard card stack
  // ============================================
  Widget _buildClassicLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
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
                padding: const EdgeInsets.all(16),
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: swipeState.candidates.length > 1 ? 2 : 1,
                  backCardOffset: const Offset(0, 40),
                  padding: EdgeInsets.zero,
                  onSwipe: _handleSwipe(swipeState),
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return _buildClassicCard(swipeState.candidates[index], percentThresholdX.toDouble());
                  },
                ),
              ),
            ),
            // Classic circular buttons at bottom
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _circleButton(Icons.close, Colors.red, 56, () => _controller.swipe(CardSwiperDirection.left)),
                  _circleButton(Icons.favorite, const Color(0xFFFF4F70), 72, () => _controller.swipe(CardSwiperDirection.right)),
                  _circleButton(Icons.star, Colors.amber, 56, () => _controller.swipe(CardSwiperDirection.top)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassicCard(Profile profile, double swipeProgress) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildProfileImage(profile),
            _buildGradientOverlay(),
            if (swipeProgress.abs() > 0.1) _buildSwipeLabel(swipeProgress > 0, 'LIKE', 'NOPE', Colors.green, Colors.red),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${profile.displayName}, ${profile.age}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  if (profile.bio != null) Text(profile.bio!, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16), maxLines: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // V2: GLASS - Full screen with frosted panel
  // ============================================
  Widget _buildFullScreenGlassLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    final profile = swipeState.candidates.isNotEmpty ? swipeState.candidates[0] : null;
    if (profile == null) return const SizedBox();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full screen image
          _buildProfileImage(profile),
          // Frosted glass overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Frosted info card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(profile.displayName, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w300, letterSpacing: 1)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('${profile.age}', style: const TextStyle(color: Colors.white, fontSize: 18)),
                              ),
                            ],
                          ),
                          if (profile.bio != null) ...[
                            const SizedBox(height: 12),
                            Text(profile.bio!, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16), maxLines: 2),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Pill-shaped buttons
                    Row(
                      children: [
                        Expanded(
                          child: _pillButton('PASS', Colors.white.withValues(alpha: 0.2), Colors.white, () {
                            ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: false);
                          }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: _pillButton('CONNECT', const Color(0xFF6366F1), Colors.white, () {
                            ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: true);
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Top status
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          const Text('Online now', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('${swipeState.candidates.length} nearby', style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // V3: CYBERPUNK - HUD/Terminal style
  // ============================================
  Widget _buildCyberpunkHUDLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    final profile = swipeState.candidates.isNotEmpty ? swipeState.candidates[0] : null;
    if (profile == null) return const SizedBox();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Top HUD bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFFF), width: 1),
                ),
                child: Row(
                  children: [
                    Container(width: 10, height: 10, color: const Color(0xFF00FF00)),
                    const SizedBox(width: 10),
                    const Text('SCAN_MODE: ACTIVE', style: TextStyle(color: Color(0xFF00FFFF), fontSize: 12, letterSpacing: 3, fontFamily: 'monospace')),
                    const Spacer(),
                    Text('${swipeState.candidates.length} TARGETS', style: const TextStyle(color: Color(0xFFFF00FF), fontSize: 12, letterSpacing: 2, fontFamily: 'monospace')),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Main content - split view
              Expanded(
                child: Row(
                  children: [
                    // Left side - Image
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF00FFFF), width: 2),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            _buildProfileImage(profile),
                            // Scanlines effect
                            ...List.generate(30, (i) => Positioned(
                              top: i * 20.0,
                              left: 0,
                              right: 0,
                              child: Container(height: 1, color: Colors.cyan.withValues(alpha: 0.1)),
                            )),
                            // Corner brackets
                            Positioned(top: 10, left: 10, child: _cornerBracket(true, true)),
                            Positioned(top: 10, right: 10, child: _cornerBracket(true, false)),
                            Positioned(bottom: 10, left: 10, child: _cornerBracket(false, true)),
                            Positioned(bottom: 10, right: 10, child: _cornerBracket(false, false)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Right side - Data panel
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Data readout
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: const Color(0xFF00FFFF), width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('// SUBJECT_DATA', style: TextStyle(color: Color(0xFF00FF00), fontSize: 10, letterSpacing: 2)),
                                  const SizedBox(height: 12),
                                  _dataRow('NAME', profile.displayName.toUpperCase()),
                                  _dataRow('AGE', '${profile.age}'),
                                  _dataRow('STATUS', 'ONLINE'),
                                  if (profile.bio != null) ...[
                                    const SizedBox(height: 8),
                                    const Text('// BIO', style: TextStyle(color: Color(0xFF00FF00), fontSize: 10)),
                                    Text('> ${profile.bio}', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11), maxLines: 4),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Action buttons - stacked
                          _neonButton('[ CONNECT ]', const Color(0xFF00FFFF), () {
                            ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: true);
                          }),
                          const SizedBox(height: 8),
                          _neonButton('[ REJECT ]', const Color(0xFFFF00FF), () {
                            ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: false);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Bottom status bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFF00FFFF).withValues(alpha: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LAT: 51.5074 | LON: -0.1278', style: TextStyle(color: const Color(0xFF00FFFF).withValues(alpha: 0.5), fontSize: 10, fontFamily: 'monospace')),
                    Text('SIGNAL: ████████░░', style: TextStyle(color: const Color(0xFF00FF00).withValues(alpha: 0.7), fontSize: 10, fontFamily: 'monospace')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cornerBracket(bool top, bool left) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _BracketPainter(top: top, left: left)),
    );
  }

  Widget _dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(color: Color(0xFF00FFFF), fontSize: 11, fontFamily: 'monospace')),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'monospace'), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _neonButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 15)],
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 3)),
        ),
      ),
    );
  }

  // ============================================
  // V4: MINIMAL - Clean, lots of whitespace
  // ============================================
  Widget _buildMinimalCleanLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Simple header
              const Text('discover', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200, color: Colors.black87, letterSpacing: -1)),
              const SizedBox(height: 8),
              Text('${swipeState.candidates.length} people nearby', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
              const SizedBox(height: 32),
              // Card
              Expanded(
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: 1,
                  backCardOffset: Offset.zero,
                  padding: EdgeInsets.zero,
                  onSwipe: _handleSwipe(swipeState),
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return _buildMinimalCard(swipeState.candidates[index]);
                  },
                ),
              ),
              const SizedBox(height: 32),
              // Minimal text buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _controller.swipe(CardSwiperDirection.left),
                    child: Text('skip', style: TextStyle(color: Colors.grey[400], fontSize: 18, fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(width: 60),
                  TextButton(
                    onPressed: () => _controller.swipe(CardSwiperDirection.right),
                    child: const Text('like', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalCard(Profile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: _buildProfileImage(profile),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.displayName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black87)),
                const SizedBox(height: 4),
                Text('${profile.age} years old', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                if (profile.bio != null) ...[
                  const SizedBox(height: 12),
                  Text(profile.bio!, style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5), maxLines: 2),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // V5: LUXURY - Magazine/editorial style
  // ============================================
  Widget _buildLuxuryMagazineLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    final profile = swipeState.candidates.isNotEmpty ? swipeState.candidates[0] : null;
    if (profile == null) return const SizedBox();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full bleed image
          _buildProfileImage(profile),
          // Elegant gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.3), Colors.black],
                stops: const [0.3, 0.6, 1.0],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top - minimal brand
                  const Center(
                    child: Text('CURATED', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, letterSpacing: 8)),
                  ),
                  const Spacer(),
                  // Name - large editorial style
                  Text(
                    profile.displayName.toUpperCase(),
                    style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 42, fontWeight: FontWeight.w200, letterSpacing: 8, height: 1.1),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(width: 40, height: 1, color: const Color(0xFFD4AF37)),
                      const SizedBox(width: 16),
                      Text('${profile.age} YEARS', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), letterSpacing: 4, fontSize: 12)),
                    ],
                  ),
                  if (profile.bio != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      '"${profile.bio}"',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16, fontStyle: FontStyle.italic, height: 1.6),
                      maxLines: 3,
                    ),
                  ],
                  const SizedBox(height: 40),
                  // Elegant buttons
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(border: Border.all(color: Colors.white.withValues(alpha: 0.3))),
                            child: const Center(child: Text('DECLINE', style: TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 12))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            color: const Color(0xFFD4AF37),
                            child: const Center(child: Text('SELECT', style: TextStyle(color: Colors.black, letterSpacing: 4, fontSize: 12))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // V6: KAWAII - Cute sticker-style
  // ============================================
  Widget _buildKawaiiCardLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Find Friends! 💖', style: TextStyle(color: Color(0xFFFF6B9D), fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Decorative header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _kawaiiBadge('${swipeState.candidates.length}', '✨ nearby'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Smaller, cuter card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: swipeState.candidates.length > 1 ? 2 : 1,
                  backCardOffset: const Offset(0, -30),
                  padding: EdgeInsets.zero,
                  onSwipe: _handleSwipe(swipeState),
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return _buildKawaiiCard(swipeState.candidates[index], percentThresholdX.toDouble());
                  },
                ),
              ),
            ),
            // Emoji buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _emojiButton('👎', const Color(0xFF74B9FF), () => _controller.swipe(CardSwiperDirection.left)),
                  _emojiButton('💕', const Color(0xFFFF6B9D), () => _controller.swipe(CardSwiperDirection.right), large: true),
                  _emojiButton('⭐', const Color(0xFFFECA57), () => _controller.swipe(CardSwiperDirection.top)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kawaiiBadge(String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0xFFFF6B9D).withValues(alpha: 0.2), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Text(count, style: const TextStyle(color: Color(0xFFFF6B9D), fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildKawaiiCard(Profile profile, double swipeProgress) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFFF6B9D).withValues(alpha: 0.3), width: 3),
        boxShadow: [
          BoxShadow(color: const Color(0xFFFF6B9D).withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildProfileImage(profile),
            // Cute overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white.withValues(alpha: 0.9)],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            // Decorative elements
            const Positioned(top: 20, right: 20, child: Text('✨', style: TextStyle(fontSize: 24))),
            const Positioned(top: 60, left: 20, child: Text('💕', style: TextStyle(fontSize: 20))),
            // Swipe indicator
            if (swipeProgress.abs() > 0.1)
              Positioned(
                top: 30,
                left: swipeProgress > 0 ? 20 : null,
                right: swipeProgress < 0 ? 20 : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: swipeProgress > 0 ? const Color(0xFFFF6B9D) : const Color(0xFF74B9FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    swipeProgress > 0 ? 'YAY! 💕' : 'NAH 👋',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            // Info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text('${profile.displayName} ✨', style: const TextStyle(color: Color(0xFFFF6B9D), fontSize: 22, fontWeight: FontWeight.bold)),
                    Text('${profile.age} years old', style: TextStyle(color: Colors.grey[500])),
                    if (profile.bio != null)
                      Text(profile.bio!, style: TextStyle(color: Colors.grey[600], fontSize: 13), maxLines: 1, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emojiButton(String emoji, Color color, VoidCallback onTap, {bool large = false}) {
    final size = large ? 80.0 : 60.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 3),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Center(child: Text(emoji, style: TextStyle(fontSize: large ? 36 : 28))),
      ),
    );
  }

  // ============================================
  // V7: BRUTALIST - Harsh, bold, aggressive
  // ============================================
  Widget _buildBrutalistLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    final profile = swipeState.candidates.isNotEmpty ? swipeState.candidates[0] : null;
    if (profile == null) return const SizedBox();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Bold header
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text('SWIPE!', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 4)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    color: Colors.black,
                    child: Text('${swipeState.candidates.length}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
            // Full width image
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 4)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildProfileImage(profile),
                    // Name overlay - bold
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.displayName.toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 2),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  color: Colors.red,
                                  child: Text('${profile.age}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                                ),
                                if (profile.bio != null) ...[
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(profile.bio!.toUpperCase(), style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1), maxLines: 1, overflow: TextOverflow.ellipsis)),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Brutal buttons
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        color: Colors.white,
                        child: const Center(child: Text('NO!', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 4))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        color: Colors.red,
                        child: const Center(child: Text('YES!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 4))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // V8: CORPORATE - LinkedIn/professional style
  // ============================================
  Widget _buildCorporateProfileLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text('Connect', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500)),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('${swipeState.candidates.length} available', style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CardSwiper(
          controller: _controller,
          cardsCount: swipeState.candidates.length,
          numberOfCardsDisplayed: swipeState.candidates.length > 1 ? 2 : 1,
          backCardOffset: const Offset(0, 30),
          padding: EdgeInsets.zero,
          onSwipe: _handleSwipe(swipeState),
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
            return _buildCorporateCard(swipeState.candidates[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCorporateCard(Profile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          // Header with image
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(height: 120, color: const Color(0xFF0078D4)),
                Positioned(
                  bottom: 0,
                  left: 24,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10)],
                    ),
                    child: ClipOval(child: _buildProfileImage(profile)),
                  ),
                ),
              ],
            ),
          ),
          // Profile info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.displayName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text('${profile.age} years old', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 16),
                  if (profile.bio != null)
                    Text(profile.bio!, style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.5), maxLines: 3),
                  const Spacer(),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _controller.swipe(CardSwiperDirection.left),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text('Skip'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () => _controller.swipe(CardSwiperDirection.right),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0078D4),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text('Connect'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // V9: BUBBLES - Playful rounded everything
  // ============================================
  Widget _buildBubbleStackLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Discover ~', style: TextStyle(color: Color(0xFF00CEC9), fontSize: 24, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: CardSwiper(
                  controller: _controller,
                  cardsCount: swipeState.candidates.length,
                  numberOfCardsDisplayed: swipeState.candidates.length > 2 ? 3 : swipeState.candidates.length,
                  backCardOffset: const Offset(0, -25),
                  scale: 0.95,
                  padding: EdgeInsets.zero,
                  onSwipe: _handleSwipe(swipeState),
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                    return _buildBubbleCard(swipeState.candidates[index]);
                  },
                ),
              ),
            ),
            // Bubble buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bubbleButton(Icons.close, const Color(0xFFFF7675), () => _controller.swipe(CardSwiperDirection.left)),
                  _bubbleButton(Icons.favorite, const Color(0xFF00CEC9), () => _controller.swipe(CardSwiperDirection.right), large: true),
                  _bubbleButton(Icons.auto_awesome, const Color(0xFFFDCB6E), () => _controller.swipe(CardSwiperDirection.top)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleCard(Profile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: const Color(0xFF00CEC9).withValues(alpha: 0.2), blurRadius: 25, offset: const Offset(0, 15))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildProfileImage(profile),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${profile.displayName}, ${profile.age}', style: const TextStyle(color: Color(0xFF00CEC9), fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  if (profile.bio != null) ...[
                    const SizedBox(height: 8),
                    Text(profile.bio!, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14), maxLines: 2),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bubbleButton(IconData icon, Color color, VoidCallback onTap, {bool large = false}) {
    final size = large ? 80.0 : 60.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withValues(alpha: 0.8), color], begin: Alignment.topLeft, end: Alignment.bottomRight),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 15, offset: const Offset(0, 8))],
        ),
        child: Icon(icon, color: Colors.white, size: large ? 36 : 28),
      ),
    );
  }

  // ============================================
  // V10: SPACE - Galaxy/cosmic style
  // ============================================
  Widget _buildSpaceGalaxyLayout(BuildContext context, SwipeState swipeState, AppThemeVariant variant) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0015),
      body: Stack(
        children: [
          // Starfield background effect
          ...List.generate(50, (i) => Positioned(
            left: (i * 37) % MediaQuery.of(context).size.width,
            top: (i * 53) % MediaQuery.of(context).size.height,
            child: Container(
              width: (i % 3) + 1.0,
              height: (i % 3) + 1.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: (i % 5) / 10 + 0.3),
                shape: BoxShape.circle,
              ),
            ),
          )),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Text('✦', style: TextStyle(color: Color(0xFFA855F7), fontSize: 24)),
                      const SizedBox(width: 12),
                      const Text('DISCOVER', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFA855F7).withValues(alpha: 0.5)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('${swipeState.candidates.length} ✦', style: const TextStyle(color: Color(0xFFA855F7))),
                      ),
                    ],
                  ),
                ),
                // Card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CardSwiper(
                      controller: _controller,
                      cardsCount: swipeState.candidates.length,
                      numberOfCardsDisplayed: swipeState.candidates.length > 2 ? 3 : swipeState.candidates.length,
                      backCardOffset: const Offset(0, 50),
                      scale: 0.9,
                      padding: EdgeInsets.zero,
                      onSwipe: _handleSwipe(swipeState),
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        return _buildSpaceCard(swipeState.candidates[index]);
                      },
                    ),
                  ),
                ),
                // Buttons
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _spaceButton(Icons.close, () => _controller.swipe(CardSwiperDirection.left)),
                      _spaceButton(Icons.favorite, () => _controller.swipe(CardSwiperDirection.right), primary: true),
                      _spaceButton(Icons.auto_awesome, () => _controller.swipe(CardSwiperDirection.top)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpaceCard(Profile profile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFA855F7).withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(color: const Color(0xFFA855F7).withValues(alpha: 0.3), blurRadius: 30, spreadRadius: 5),
          BoxShadow(color: const Color(0xFFEC4899).withValues(alpha: 0.2), blurRadius: 50, offset: const Offset(0, 20)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildProfileImage(profile),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, const Color(0xFF0C0015).withValues(alpha: 0.9)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.displayName, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('✦', style: TextStyle(color: Color(0xFFA855F7))),
                      const SizedBox(width: 8),
                      Text('${profile.age} years', style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                  if (profile.bio != null) ...[
                    const SizedBox(height: 12),
                    Text(profile.bio!, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14), maxLines: 2),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _spaceButton(IconData icon, VoidCallback onTap, {bool primary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: primary ? 80 : 60,
        height: primary ? 80 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: primary
              ? const LinearGradient(colors: [Color(0xFFA855F7), Color(0xFFEC4899)])
              : null,
          color: primary ? null : const Color(0xFF1A0A2E),
          border: Border.all(color: const Color(0xFFA855F7).withValues(alpha: primary ? 0 : 0.5), width: 2),
          boxShadow: primary
              ? [BoxShadow(color: const Color(0xFFA855F7).withValues(alpha: 0.5), blurRadius: 20)]
              : null,
        ),
        child: Icon(icon, color: Colors.white, size: primary ? 36 : 28),
      ),
    );
  }

  // ============================================
  // SHARED HELPERS
  // ============================================
  Widget _buildProfileImage(Profile profile) {
    if (profile.photoUrl != null) {
      return CachedNetworkImage(
        imageUrl: profile.photoUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey[800]),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[800],
          child: const Icon(Icons.person, size: 60, color: Colors.grey),
        ),
      );
    }
    return Container(
      color: Colors.grey[800],
      child: const Icon(Icons.person, size: 60, color: Colors.grey),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildSwipeLabel(bool isLike, String likeText, String nopeText, Color likeColor, Color nopeColor) {
    return Positioned(
      top: 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Transform.rotate(
        angle: isLike ? -0.3 : 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: isLike ? likeColor : nopeColor, width: 4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(isLike ? likeText : nopeText, style: TextStyle(color: isLike ? likeColor : nopeColor, fontSize: 32, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, Color color, double size, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 2)],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }

  Widget _pillButton(String text, Color bgColor, Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1))),
      ),
    );
  }

  CardSwiperOnSwipe _handleSwipe(SwipeState swipeState) {
    return (previousIndex, currentIndex, direction) {
      final profile = swipeState.candidates[previousIndex];
      final isLike = direction == CardSwiperDirection.right;
      ref.read(swipeNotifierProvider.notifier).swipe(targetUserId: profile.userId, isLike: isLike);
      return true;
    };
  }

  Widget _buildEmptyState(BuildContext context, AppThemeVariant variant, Color primaryColor, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: primaryColor.withValues(alpha: 0.5)),
            const SizedBox(height: 24),
            const Text('No more profiles', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Check back later!', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => ref.read(swipeNotifierProvider.notifier).loadCandidates(),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for cyberpunk corner brackets
class _BracketPainter extends CustomPainter {
  final bool top;
  final bool left;

  _BracketPainter({required this.top, required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FFFF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
