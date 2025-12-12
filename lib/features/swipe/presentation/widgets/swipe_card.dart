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
    final cardRadius = getCardBorderRadius(variant);
    final isDark = isThemeDark(variant);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: _getShadowForVariant(variant),
        border: _getBorderForVariant(variant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            if (profile.photoUrl != null)
              CachedNetworkImage(
                imageUrl: profile.photoUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: const Icon(Icons.person, size: 100, color: Colors.grey),
                ),
              )
            else
              Container(
                color: Theme.of(context).colorScheme.surface,
                child: const Icon(Icons.person, size: 100, color: Colors.grey),
              ),

            // Gradient overlay - different per variant
            _buildGradientOverlay(variant),

            // Neon border effect for cyberpunk
            if (variant == AppThemeVariant.v3DarkNeon)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardRadius),
                    border: Border.all(
                      color: const Color(0xFF00FFFF),
                      width: 2,
                    ),
                  ),
                ),
              ),

            // Like/Nope indicators - styled per variant
            if (swipeProgress != 0) _buildSwipeIndicator(variant),

            // Profile info - styled per variant
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildProfileInfo(context, variant, isDark),
            ),
          ],
        ),
      ),
    );
  }

  List<BoxShadow> _getShadowForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return [
          BoxShadow(
            color: const Color(0xFF00FFFF).withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ];
      case AppThemeVariant.v5LuxuryGoldBlack:
        return [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ];
      case AppThemeVariant.v6PlayfulPastel:
        return [
          BoxShadow(
            color: const Color(0xFFFF6B9D).withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 8,
            offset: const Offset(0, 10),
          ),
        ];
      case AppThemeVariant.v7HighContrastRed:
        return [
          const BoxShadow(
            color: Colors.red,
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(8, 8),
          ),
        ];
      case AppThemeVariant.v9RoundedBubbles:
        return [
          BoxShadow(
            color: const Color(0xFF00CEC9).withValues(alpha: 0.4),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ];
      case AppThemeVariant.v10CardStack3D:
        return [
          BoxShadow(
            color: const Color(0xFFA855F7).withValues(alpha: 0.4),
            blurRadius: 25,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: const Color(0xFFEC4899).withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ];
      case AppThemeVariant.v2ModernGlassblur:
        return [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.2),
            blurRadius: 50,
            spreadRadius: 15,
          ),
        ];
      case AppThemeVariant.v8BlueCorporate:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ];
      default:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ];
    }
  }

  Border? _getBorderForVariant(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v5LuxuryGoldBlack:
        return Border.all(color: const Color(0xFFD4AF37), width: 3);
      case AppThemeVariant.v7HighContrastRed:
        return Border.all(color: Colors.red, width: 6);
      case AppThemeVariant.v6PlayfulPastel:
        return Border.all(color: const Color(0xFFFFB8D0), width: 4);
      case AppThemeVariant.v9RoundedBubbles:
        return Border.all(color: const Color(0xFF00CEC9), width: 3);
      case AppThemeVariant.v8BlueCorporate:
        return Border.all(color: const Color(0xFF0078D4), width: 2);
      case AppThemeVariant.v10CardStack3D:
        return Border.all(color: const Color(0xFFA855F7), width: 2);
      default:
        return null;
    }
  }

  Widget _buildGradientOverlay(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0A0A0A).withValues(alpha: 0.3),
                const Color(0xFF0A0A0A).withValues(alpha: 0.95),
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
                const Color(0xFFFFE4EC).withValues(alpha: 0.0),
                const Color(0xFFFFE4EC).withValues(alpha: 0.6),
                const Color(0xFFFFE4EC).withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.5, 1.0],
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
                Colors.black.withValues(alpha: 0.6),
                Colors.black.withValues(alpha: 0.98),
              ],
              stops: const [0.0, 0.35, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v7HighContrastRed:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black,
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v9RoundedBubbles:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFFE8F8F5).withValues(alpha: 0.5),
                const Color(0xFFE8F8F5).withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v10CardStack3D:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.transparent,
                const Color(0xFF1A0A2E).withValues(alpha: 0.5),
                const Color(0xFF1A0A2E).withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v2ModernGlassblur:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0F0F23).withValues(alpha: 0.4),
                const Color(0xFF0F0F23).withValues(alpha: 0.85),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      case AppThemeVariant.v8BlueCorporate:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF0078D4).withValues(alpha: 0.3),
                const Color(0xFF002050).withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.6, 1.0],
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

  Widget _buildSwipeIndicator(AppThemeVariant variant) {
    final isLike = swipeProgress > 0;
    Color likeColor;
    Color nopeColor;
    String likeText;
    String nopeText;
    double fontSize;
    double borderWidth;
    double borderRadius;
    Color? bgColor;
    List<BoxShadow>? shadows;

    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        likeColor = const Color(0xFF00FF00);
        nopeColor = const Color(0xFFFF00FF);
        likeText = 'CONNECT';
        nopeText = 'REJECT';
        fontSize = 28;
        borderWidth = 3;
        borderRadius = 0;
        bgColor = Colors.black.withValues(alpha: 0.8);
        shadows = [BoxShadow(color: (isLike ? likeColor : nopeColor).withValues(alpha: 0.7), blurRadius: 25)];
        break;
      case AppThemeVariant.v5LuxuryGoldBlack:
        likeColor = const Color(0xFFD4AF37);
        nopeColor = const Color(0xFF666666);
        likeText = 'EXQUISITE';
        nopeText = 'DECLINE';
        fontSize = 24;
        borderWidth = 2;
        borderRadius = 0;
        bgColor = Colors.black.withValues(alpha: 0.6);
        break;
      case AppThemeVariant.v6PlayfulPastel:
        likeColor = const Color(0xFFFF6B9D);
        nopeColor = const Color(0xFF74B9FF);
        likeText = 'CUTE! 💕';
        nopeText = 'BYE! 👋';
        fontSize = 28;
        borderWidth = 5;
        borderRadius = 30;
        bgColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppThemeVariant.v7HighContrastRed:
        likeColor = const Color(0xFF00FF00);
        nopeColor = const Color(0xFFFF0000);
        likeText = 'YES!!!';
        nopeText = 'NO!!!';
        fontSize = 48;
        borderWidth = 8;
        borderRadius = 0;
        bgColor = Colors.black;
        break;
      case AppThemeVariant.v9RoundedBubbles:
        likeColor = const Color(0xFF00CEC9);
        nopeColor = const Color(0xFFFF7675);
        likeText = 'Love it!';
        nopeText = 'Next!';
        fontSize = 26;
        borderWidth = 4;
        borderRadius = 50;
        bgColor = Colors.white.withValues(alpha: 0.9);
        shadows = [BoxShadow(color: (isLike ? likeColor : nopeColor).withValues(alpha: 0.4), blurRadius: 15, spreadRadius: 2)];
        break;
      case AppThemeVariant.v10CardStack3D:
        likeColor = const Color(0xFFA855F7);
        nopeColor = const Color(0xFFEC4899);
        likeText = '✨ SPARK';
        nopeText = '💫 SKIP';
        fontSize = 26;
        borderWidth = 3;
        borderRadius = 12;
        bgColor = const Color(0xFF1A0A2E).withValues(alpha: 0.9);
        shadows = [BoxShadow(color: (isLike ? likeColor : nopeColor).withValues(alpha: 0.5), blurRadius: 20)];
        break;
      case AppThemeVariant.v2ModernGlassblur:
        likeColor = const Color(0xFF6366F1);
        nopeColor = const Color(0xFFF43F5E);
        likeText = 'MATCH';
        nopeText = 'SKIP';
        fontSize = 28;
        borderWidth = 2;
        borderRadius = 16;
        bgColor = Colors.white.withValues(alpha: 0.15);
        break;
      case AppThemeVariant.v8BlueCorporate:
        likeColor = const Color(0xFF00A651);
        nopeColor = const Color(0xFFD32F2F);
        likeText = 'APPROVE';
        nopeText = 'DECLINE';
        fontSize = 22;
        borderWidth = 2;
        borderRadius = 4;
        bgColor = Colors.white.withValues(alpha: 0.9);
        break;
      default:
        likeColor = const Color(0xFF4CAF50);
        nopeColor = const Color(0xFFE91E63);
        likeText = 'LIKE';
        nopeText = 'NOPE';
        fontSize = 32;
        borderWidth = 4;
        borderRadius = 8;
    }

    return Positioned(
      top: variant == AppThemeVariant.v7HighContrastRed ? 20 : 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Transform.rotate(
        angle: isLike ? -0.3 : 0.3,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: variant == AppThemeVariant.v7HighContrastRed ? 20 : 16, 
            vertical: variant == AppThemeVariant.v7HighContrastRed ? 12 : 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isLike ? likeColor : nopeColor,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            color: bgColor,
            boxShadow: shadows,
          ),
          child: Text(
            isLike ? likeText : nopeText,
            style: TextStyle(
              color: isLike ? likeColor : nopeColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 4 : 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, AppThemeVariant variant, bool isDark) {
    // Variant-specific styling
    switch (variant) {
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryProfileInfo();
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelProfileInfo();
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldProfileInfo();
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleProfileInfo();
      case AppThemeVariant.v10CardStack3D:
        return _buildSpaceProfileInfo();
      case AppThemeVariant.v2ModernGlassblur:
        return _buildGlassProfileInfo();
      case AppThemeVariant.v8BlueCorporate:
        return _buildCorporateProfileInfo();
      default:
        return _buildDefaultProfileInfo();
    }
  }

  Widget _buildDefaultProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                profile.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
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

  Widget _buildLuxuryProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: Color(0xFFD4AF37), width: 1),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.3)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.displayName.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 28,
              fontWeight: FontWeight.w300,
              letterSpacing: 6,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD4AF37)),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '◆  VERIFIED',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 11,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              '"${profile.bio}"',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B9D).withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                profile.displayName,
                style: const TextStyle(
                  color: Color(0xFFFF6B9D),
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFECA57),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              const Text('✨', style: TextStyle(fontSize: 24)),
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              profile.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF666666),
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
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.displayName.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  'AGE ${profile.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: const Text(
                  'ACTIVE NOW',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF00CEC9), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.displayName,
                  style: const TextStyle(
                    color: Color(0xFF2D3436),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.bio ?? 'Hey there! 👋',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF636E72),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00CEC9), Color(0xFF00B894)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${profile.age}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpaceProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF1A0A2E).withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                ).createShader(bounds),
                child: Text(
                  profile.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGlassProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                profile.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${profile.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
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
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCorporateProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white.withValues(alpha: 0.95),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: const TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.bio ?? 'Professional member',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${profile.age}',
                style: const TextStyle(
                  color: Color(0xFF0078D4),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'years',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
