import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/models/profile.dart';
import '../../../../core/providers/theme_provider.dart';

class SwipeCard extends ConsumerWidget {
  final Profile profile;
  final double swipeProgress;

  const SwipeCard({
    super.key,
    required this.profile,
    this.swipeProgress = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variant = ref.watch(themeVariantProvider);
    final primaryColor = getThemePrimaryColor(variant);
    final secondaryColor = getThemeSecondaryColor(variant);
    final cardRadius = getCardBorderRadius(variant);
    final isDark = isThemeDark(variant);
    final texts = getSwipeScreenTexts(variant);

    return Container(
      decoration: _getCardDecoration(variant, cardRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            _buildBackgroundImage(context, variant, primaryColor),

            // Variant-specific overlay
            _buildOverlay(variant),

            // Variant-specific decorations
            _buildDecorations(variant, cardRadius),

            // Like/Nope indicators
            if (swipeProgress.abs() > 0.1) 
              _buildSwipeIndicator(variant, texts),

            // Profile info at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildProfileInfo(context, variant, isDark, primaryColor, secondaryColor),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getCardDecoration(AppThemeVariant variant, double radius) {
    switch (variant) {
      case AppThemeVariant.v1ClassicTinder:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        );
      case AppThemeVariant.v2ModernGlassblur:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        );
      case AppThemeVariant.v3DarkNeon:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFF00FFFF),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00FFFF).withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: const Color(0xFFFF00FF).withValues(alpha: 0.3),
              blurRadius: 50,
              spreadRadius: 5,
            ),
          ],
        );
      case AppThemeVariant.v4MinimalSoft:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFD4AF37),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        );
      case AppThemeVariant.v6PlayfulPastel:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFFF6B9D).withValues(alpha: 0.5),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B9D).withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: const Color(0xFFFECA57).withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(10, 10),
            ),
          ],
        );
      case AppThemeVariant.v7HighContrastRed:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: Colors.red,
            width: 6,
          ),
          boxShadow: [
            const BoxShadow(
              color: Colors.red,
              blurRadius: 0,
              spreadRadius: 2,
            ),
          ],
        );
      case AppThemeVariant.v8BlueCorporate:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        );
      case AppThemeVariant.v9RoundedBubbles:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFF00CEC9),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00CEC9).withValues(alpha: 0.3),
              blurRadius: 25,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        );
      case AppThemeVariant.v10CardStack3D:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: const Color(0xFFA855F7).withValues(alpha: 0.6),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA855F7).withValues(alpha: 0.4),
              blurRadius: 30,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: const Color(0xFFEC4899).withValues(alpha: 0.2),
              blurRadius: 50,
              spreadRadius: 5,
              offset: const Offset(0, 20),
            ),
          ],
        );
    }
  }

  Widget _buildBackgroundImage(BuildContext context, AppThemeVariant variant, Color primaryColor) {
    if (profile.photoUrl != null) {
      return CachedNetworkImage(
        imageUrl: profile.photoUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: CircularProgressIndicator(color: primaryColor),
          ),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(context, variant),
      );
    }
    return _buildPlaceholder(context, variant);
  }

  Widget _buildPlaceholder(BuildContext context, AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Container(
          color: const Color(0xFF0A0A0A),
          child: const Center(
            child: Icon(Icons.person, size: 100, color: Color(0xFF00FFFF)),
          ),
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        return Container(
          color: Colors.black,
          child: const Center(
            child: Icon(Icons.person, size: 100, color: Color(0xFFD4AF37)),
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B9D), Color(0xFFFECA57)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(Icons.sentiment_very_satisfied, size: 100, color: Colors.white),
          ),
        );
      default:
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: const Icon(Icons.person, size: 100, color: Colors.grey),
        );
    }
  }

  Widget _buildOverlay(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v2ModernGlassblur:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v3DarkNeon:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0A0A0A).withValues(alpha: 0.5),
                const Color(0xFF0A0A0A).withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.3),
                Colors.white.withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v7HighContrastRed:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v10CardStack3D:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0C0015).withValues(alpha: 0.6),
                const Color(0xFF0C0015).withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      default:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
    }
  }

  Widget _buildDecorations(AppThemeVariant variant, double radius) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        // Scanlines effect
        return Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                children: List.generate(
                  50,
                  (i) => Expanded(
                    child: Container(
                      color: i % 2 == 0 
                          ? Colors.transparent 
                          : Colors.black.withValues(alpha: 0.03),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        // Corner accents
        return Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFD4AF37), width: 2),
                    left: BorderSide(color: Color(0xFFD4AF37), width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFD4AF37), width: 2),
                    right: BorderSide(color: Color(0xFFD4AF37), width: 2),
                  ),
                ),
              ),
            ),
          ],
        );
      case AppThemeVariant.v6PlayfulPastel:
        // Floating hearts/stars
        return Stack(
          children: [
            Positioned(
              top: 30,
              right: 30,
              child: Text(
                '✨',
                style: TextStyle(fontSize: 24, color: Colors.white.withValues(alpha: 0.8)),
              ),
            ),
            Positioned(
              top: 80,
              left: 25,
              child: Text(
                '💕',
                style: TextStyle(fontSize: 20, color: Colors.white.withValues(alpha: 0.8)),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSwipeIndicator(AppThemeVariant variant, SwipeScreenTexts texts) {
    final isLike = swipeProgress > 0;
    
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonIndicator(isLike, texts);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryIndicator(isLike, texts);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelIndicator(isLike, texts);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldIndicator(isLike, texts);
      default:
        return _buildDefaultIndicator(isLike, texts, variant);
    }
  }

  Widget _buildDefaultIndicator(bool isLike, SwipeScreenTexts texts, AppThemeVariant variant) {
    final color = isLike ? Colors.green : Colors.red;
    return Positioned(
      top: 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Transform.rotate(
        angle: isLike ? -0.3 : 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isLike ? texts.likeText : texts.nopeText,
            style: TextStyle(
              color: color,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNeonIndicator(bool isLike, SwipeScreenTexts texts) {
    final color = isLike ? const Color(0xFF00FF00) : const Color(0xFFFF00FF);
    return Positioned(
      top: 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.6),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          isLike ? texts.likeText : texts.nopeText,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryIndicator(bool isLike, SwipeScreenTexts texts) {
    final color = isLike ? const Color(0xFFD4AF37) : Colors.grey;
    return Positioned(
      top: 50,
      left: isLike ? 30 : null,
      right: !isLike ? 30 : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
        ),
        child: Text(
          isLike ? texts.likeText : texts.nopeText,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildPastelIndicator(bool isLike, SwipeScreenTexts texts) {
    final color = isLike ? const Color(0xFFFF6B9D) : const Color(0xFF74B9FF);
    return Positioned(
      top: 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Transform.rotate(
        angle: isLike ? -0.2 : 0.2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            isLike ? texts.likeText : texts.nopeText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBoldIndicator(bool isLike, SwipeScreenTexts texts) {
    return Positioned(
      top: 30,
      left: isLike ? 10 : null,
      right: !isLike ? 10 : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isLike ? Colors.white : Colors.red,
          border: Border.all(
            color: isLike ? Colors.black : Colors.white,
            width: 4,
          ),
        ),
        child: Text(
          isLike ? texts.likeText : texts.nopeText,
          style: TextStyle(
            color: isLike ? Colors.black : Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(
    BuildContext context,
    AppThemeVariant variant,
    bool isDark,
    Color primaryColor,
    Color secondaryColor,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonProfileInfo();
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryProfileInfo();
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelProfileInfo();
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldProfileInfo();
      default:
        return _buildDefaultProfileInfo(context, isDark, primaryColor);
    }
  }

  Widget _buildDefaultProfileInfo(BuildContext context, bool isDark, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  profile.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              profile.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNeonProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: Color(0xFF00FFFF), width: 1),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0A0A0A).withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  profile.displayName.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF00FFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFF00FF)),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Color(0xFFFF00FF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00FF00), width: 1),
            ),
            child: const Text(
              'ONLINE',
              style: TextStyle(
                color: Color(0xFF00FF00),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '> ${profile.bio!}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLuxuryProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.displayName,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 30,
                height: 1,
                color: const Color(0xFFD4AF37),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age} years',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              profile.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPastelProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.8),
            Colors.white.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${profile.displayName} ✨',
                  style: const TextStyle(
                    color: Color(0xFFFF6B9D),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFECA57),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              profile.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.6),
                fontSize: 15,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBoldProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (profile.bio != null && profile.bio!.isNotEmpty)
                  Text(
                    profile.bio!.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Text(
              '${profile.age}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
