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
      case AppThemeVariant.v10CardStack3D:
        return [
          BoxShadow(
            color: const Color(0xFFA855F7).withValues(alpha: 0.4),
            blurRadius: 25,
            spreadRadius: 3,
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
        return Border.all(color: const Color(0xFFD4AF37), width: 2);
      case AppThemeVariant.v7HighContrastRed:
        return Border.all(color: Colors.red, width: 4);
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
                Colors.transparent,
                Colors.white.withValues(alpha: 0.5),
                Colors.white.withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.6, 1.0],
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
                Colors.black.withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.4, 1.0],
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

    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        likeColor = const Color(0xFF00FF00);
        nopeColor = const Color(0xFFFF00FF);
        likeText = 'MATCH';
        nopeText = 'SKIP';
        break;
      case AppThemeVariant.v5LuxuryGoldBlack:
        likeColor = const Color(0xFFD4AF37);
        nopeColor = Colors.grey;
        likeText = 'INTERESTED';
        nopeText = 'PASS';
        break;
      case AppThemeVariant.v6PlayfulPastel:
        likeColor = const Color(0xFFFF6B9D);
        nopeColor = const Color(0xFF74B9FF);
        likeText = 'YAY! 💕';
        nopeText = 'NAH 👋';
        break;
      case AppThemeVariant.v7HighContrastRed:
        likeColor = const Color(0xFF00FF00);
        nopeColor = const Color(0xFFFF0000);
        likeText = 'YES!';
        nopeText = 'NO!';
        break;
      default:
        likeColor = Colors.green;
        nopeColor = Colors.red;
        likeText = 'LIKE';
        nopeText = 'NOPE';
    }

    return Positioned(
      top: 40,
      left: isLike ? 20 : null,
      right: !isLike ? 20 : null,
      child: Transform.rotate(
        angle: isLike ? -0.3 : 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: isLike ? likeColor : nopeColor,
              width: variant == AppThemeVariant.v7HighContrastRed ? 6 : 4,
            ),
            borderRadius: BorderRadius.circular(
              variant == AppThemeVariant.v6PlayfulPastel ? 20 : 8,
            ),
            color: variant == AppThemeVariant.v3DarkNeon
                ? Colors.black.withValues(alpha: 0.7)
                : null,
            boxShadow: variant == AppThemeVariant.v3DarkNeon
                ? [
                    BoxShadow(
                      color: (isLike ? likeColor : nopeColor).withValues(alpha: 0.5),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Text(
            isLike ? likeText : nopeText,
            style: TextStyle(
              color: isLike ? likeColor : nopeColor,
              fontSize: variant == AppThemeVariant.v7HighContrastRed ? 40 : 32,
              fontWeight: FontWeight.bold,
              letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 3 : 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, AppThemeVariant variant, bool isDark) {
    final textColor = variant == AppThemeVariant.v6PlayfulPastel 
        ? Colors.black87 
        : Colors.white;
    final subtitleColor = variant == AppThemeVariant.v6PlayfulPastel
        ? Colors.black54
        : Colors.white.withValues(alpha: 0.9);

    return Container(
      padding: EdgeInsets.all(
        variant == AppThemeVariant.v5LuxuryGoldBlack ? 24 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                profile.displayName,
                style: TextStyle(
                  color: variant == AppThemeVariant.v5LuxuryGoldBlack
                      ? const Color(0xFFD4AF37)
                      : textColor,
                  fontSize: variant == AppThemeVariant.v5LuxuryGoldBlack ? 32 : 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 2 : 0,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                ),
              ),
              if (variant == AppThemeVariant.v3DarkNeon) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00FFFF)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'ONLINE',
                    style: TextStyle(
                      color: Color(0xFF00FFFF),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              profile.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: subtitleColor,
                fontSize: 16,
                fontStyle: variant == AppThemeVariant.v5LuxuryGoldBlack 
                    ? FontStyle.italic 
                    : FontStyle.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
