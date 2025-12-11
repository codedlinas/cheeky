import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/providers/theme_provider.dart';
import '../../providers/matches_provider.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(matchesProvider);
    final variant = ref.watch(themeVariantProvider);
    final primaryColor = getThemePrimaryColor(variant);
    final surfaceColor = getThemeSurfaceColor(variant);
    final isDark = isThemeDark(variant);
    final cardRadius = getCardBorderRadius(variant);

    return Scaffold(
      appBar: _buildAppBar(context, variant),
      body: matchesAsync.when(
        data: (matches) {
          if (matches.isEmpty) {
            return _buildEmptyState(context, variant, primaryColor, isDark);
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(matchesProvider.future),
            color: primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                final otherUser = match.otherUser;

                return _buildMatchCard(
                  context,
                  variant,
                  match,
                  otherUser,
                  primaryColor,
                  surfaceColor,
                  isDark,
                  cardRadius,
                );
              },
            ),
          );
        },
        loading: () => Center(
          child: _buildLoadingIndicator(variant, primaryColor),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(matchesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppThemeVariant variant) {
    String title;
    TextStyle? titleStyle;

    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        title = '> LINKS_';
        titleStyle = const TextStyle(
          fontFamily: 'monospace',
          letterSpacing: 4,
          fontSize: 18,
        );
        break;
      case AppThemeVariant.v5LuxuryGoldBlack:
        title = 'CONNECTIONS';
        titleStyle = const TextStyle(
          letterSpacing: 6,
          fontWeight: FontWeight.w200,
          fontSize: 16,
        );
        break;
      case AppThemeVariant.v6PlayfulPastel:
        title = 'My Friends! 💕';
        titleStyle = const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFF6B9D),
        );
        break;
      case AppThemeVariant.v7HighContrastRed:
        title = 'MATCHES';
        titleStyle = const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        );
        break;
      default:
        title = 'Matches';
        titleStyle = null;
    }

    return AppBar(
      title: Text(title, style: titleStyle),
      centerTitle: variant != AppThemeVariant.v3DarkNeon,
    );
  }

  Widget _buildLoadingIndicator(AppThemeVariant variant, Color primaryColor) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            const Text(
              'LOADING...',
              style: TextStyle(
                color: Color(0xFF00FFFF),
                letterSpacing: 4,
                fontFamily: 'monospace',
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
    Color primaryColor,
    bool isDark,
  ) {
    IconData icon;
    String title;
    String subtitle;

    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        icon = Icons.link_off;
        title = '// NO_CONNECTIONS';
        subtitle = 'SCANNING FOR MATCHES...';
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFFF), width: 2),
                ),
                child: Icon(icon, size: 60, color: const Color(0xFF00FFFF)),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF00FFFF),
                  letterSpacing: 3,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  letterSpacing: 2,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      case AppThemeVariant.v5LuxuryGoldBlack:
        icon = Icons.diamond_outlined;
        title = 'No Connections Yet';
        subtitle = 'Your selections will appear here';
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: const Color(0xFFD4AF37)),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFD4AF37),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      case AppThemeVariant.v6PlayfulPastel:
        icon = Icons.favorite_border;
        title = 'No matches yet 💔';
        subtitle = 'Keep swiping to find friends!';
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
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B9D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
        );
      default:
        icon = Icons.favorite_border;
        title = 'No matches yet';
        subtitle = 'Start swiping to find your match!';
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMatchCard(
    BuildContext context,
    AppThemeVariant variant,
    dynamic match,
    dynamic otherUser,
    Color primaryColor,
    Color surfaceColor,
    bool isDark,
    double cardRadius,
  ) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildNeonMatchCard(context, match, otherUser);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryMatchCard(context, match, otherUser);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelMatchCard(context, match, otherUser);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldMatchCard(context, match, otherUser);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleMatchCard(context, match, otherUser, primaryColor);
      default:
        return _buildDefaultMatchCard(
          context,
          match,
          otherUser,
          primaryColor,
          surfaceColor,
          cardRadius,
        );
    }
  }

  Widget _buildDefaultMatchCard(
    BuildContext context,
    dynamic match,
    dynamic otherUser,
    Color primaryColor,
    Color surfaceColor,
    double cardRadius,
  ) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: ClipOval(
                child: otherUser?.photoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: otherUser!.photoUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: surfaceColor,
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      )
                    : Container(
                        color: surfaceColor,
                        child: const Icon(Icons.person, color: Colors.grey, size: 35),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser?.displayName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Matched ${timeago.format(match.createdAt)}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.chat_bubble_outline, color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonMatchCard(BuildContext context, dynamic match, dynamic otherUser) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: const Color(0xFF00FFFF), width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00FFFF).withValues(alpha: 0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFF00FF), width: 2),
              ),
              child: otherUser?.photoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: otherUser!.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, color: Color(0xFF00FFFF), size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (otherUser?.displayName ?? 'Unknown').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00FFFF),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00FF00),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'LINKED ${timeago.format(match.createdAt).toUpperCase()}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 10,
                          letterSpacing: 2,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFFFF00)),
              ),
              child: const Icon(Icons.chat, color: Color(0xFFFFFF00), size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuxuryMatchCard(BuildContext context, dynamic match, dynamic otherUser) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4AF37), width: 1),
              ),
              child: otherUser?.photoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: otherUser!.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, color: Color(0xFFD4AF37), size: 35),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser?.displayName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFD4AF37),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 1,
                        color: const Color(0xFFD4AF37),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeago.format(match.createdAt),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4AF37)),
              ),
              child: const Icon(Icons.chat_bubble_outline, color: Color(0xFFD4AF37), size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastelMatchCard(BuildContext context, dynamic match, dynamic otherUser) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B9D).withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFF6B9D), width: 3),
              ),
              child: ClipOval(
                child: otherUser?.photoUrl != null
                    ? CachedNetworkImage(
                        imageUrl: otherUser!.photoUrl!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: const Color(0xFFFFF5F7),
                        child: const Icon(Icons.sentiment_satisfied_alt, color: Color(0xFFFF6B9D), size: 30),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${otherUser?.displayName ?? 'Unknown'} ✨',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B9D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Matched ${timeago.format(match.createdAt)} 💕',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFECA57),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.chat_bubble, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoldMatchCard(BuildContext context, dynamic match, dynamic otherUser) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
              ),
              child: otherUser?.photoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: otherUser!.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (otherUser?.displayName ?? 'Unknown').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    timeago.format(match.createdAt).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.red,
              child: const Icon(Icons.chat, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleMatchCard(BuildContext context, dynamic match, dynamic otherUser, Color primaryColor) {
    return GestureDetector(
      onTap: () => context.push('/chat/${match.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: otherUser?.photoUrl != null
                      ? CachedNetworkImage(
                          imageUrl: otherUser!.photoUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.white,
                          child: Icon(Icons.person, color: primaryColor, size: 30),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser?.displayName ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Matched ${timeago.format(match.createdAt)}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primaryColor, const Color(0xFF81ECEC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.chat_bubble, color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
