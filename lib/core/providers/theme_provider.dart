import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Available UI themes/variants
enum AppThemeVariant {
  v1ClassicTinder,
  v2ModernGlassblur,
  v3DarkNeon,
  v4MinimalSoft,
  v5LuxuryGoldBlack,
  v6PlayfulPastel,
  v7HighContrastRed,
  v8BlueCorporate,
  v9RoundedBubbles,
  v10CardStack3D,
}

/// Theme variant state provider
final themeVariantProvider = StateNotifierProvider<ThemeVariantNotifier, AppThemeVariant>((ref) {
  return ThemeVariantNotifier();
});

class ThemeVariantNotifier extends StateNotifier<AppThemeVariant> {
  ThemeVariantNotifier() : super(AppThemeVariant.v1ClassicTinder);

  void setVariant(AppThemeVariant variant) {
    state = variant;
  }
}

/// Get theme name for display
String getThemeName(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return 'Classic Tinder';
    case AppThemeVariant.v2ModernGlassblur:
      return 'Glassmorphism';
    case AppThemeVariant.v3DarkNeon:
      return 'Cyberpunk Neon';
    case AppThemeVariant.v4MinimalSoft:
      return 'Clean Minimal';
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 'Luxury Gold';
    case AppThemeVariant.v6PlayfulPastel:
      return 'Kawaii Pastel';
    case AppThemeVariant.v7HighContrastRed:
      return 'Bold & Fierce';
    case AppThemeVariant.v8BlueCorporate:
      return 'Professional';
    case AppThemeVariant.v9RoundedBubbles:
      return 'Bubbly Fun';
    case AppThemeVariant.v10CardStack3D:
      return 'Space Purple';
  }
}

/// Get primary color for each theme
Color getThemePrimaryColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFFFF4F70); // Hot pink
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF6366F1); // Indigo
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF00FFFF); // Cyan neon
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFF2D3436); // Charcoal
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFFD4AF37); // Gold
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFF6B9D); // Soft pink
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFFFF0000); // Pure red
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFF0078D4); // Microsoft blue
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFF00CEC9); // Turquoise
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFFA855F7); // Vivid purple
  }
}

/// Get secondary color for each theme
Color getThemeSecondaryColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFFFF6B6B);
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFFA855F7);
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFFFF00FF); // Magenta neon
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFF636E72);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFFF5E6CC);
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFECA57); // Yellow
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFF00A4EF);
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFFF7675); // Coral
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFFEC4899);
  }
}

/// Get tertiary/accent color for each theme
Color getThemeTertiaryColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFFFFA500); // Orange
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF06B6D4); // Cyan
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF00FF00); // Green neon
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFFB2BEC3);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFFCDAA7D); // Bronze
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFF74B9FF); // Light blue
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFF000000);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFF7FBA00); // Green
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFFDCB6E); // Yellow
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFF06B6D4);
  }
}

/// Get background color for each theme
Color getThemeBackgroundColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFF121212);
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF0F0F23);
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF0A0A0A);
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFFFAFAFA);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFF000000);
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFFF5F7);
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFF000000);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFFF5F5F5);
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFE8F8F5);
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFF0C0015);
  }
}

/// Get surface/card color
Color getThemeSurfaceColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFF1E1E1E);
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF1A1A2E).withValues(alpha: 0.7);
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF1A1A2E);
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFF1A1A1A);
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFF1A0000);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFF1A0A2E);
  }
}

/// Is this a dark theme?
bool isThemeDark(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
    case AppThemeVariant.v2ModernGlassblur:
    case AppThemeVariant.v3DarkNeon:
    case AppThemeVariant.v5LuxuryGoldBlack:
    case AppThemeVariant.v7HighContrastRed:
    case AppThemeVariant.v10CardStack3D:
      return true;
    case AppThemeVariant.v4MinimalSoft:
    case AppThemeVariant.v6PlayfulPastel:
    case AppThemeVariant.v8BlueCorporate:
    case AppThemeVariant.v9RoundedBubbles:
      return false;
  }
}

/// Get card border radius - more variety!
double getCardBorderRadius(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return 16;
    case AppThemeVariant.v2ModernGlassblur:
      return 28; // Smoother, larger
    case AppThemeVariant.v3DarkNeon:
      return 2; // Almost sharp, cyber edges
    case AppThemeVariant.v4MinimalSoft:
      return 6; // Subtle
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 0; // No radius - sharp luxury
    case AppThemeVariant.v6PlayfulPastel:
      return 40; // Very rounded, playful
    case AppThemeVariant.v7HighContrastRed:
      return 0; // Sharp aggressive
    case AppThemeVariant.v8BlueCorporate:
      return 4; // Corporate subtle
    case AppThemeVariant.v9RoundedBubbles:
      return 60; // Super bubble
    case AppThemeVariant.v10CardStack3D:
      return 24;
  }
}

/// Get button border radius
double getButtonBorderRadius(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return 30;
    case AppThemeVariant.v2ModernGlassblur:
      return 16;
    case AppThemeVariant.v3DarkNeon:
      return 0; // Sharp
    case AppThemeVariant.v4MinimalSoft:
      return 8;
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 0;
    case AppThemeVariant.v6PlayfulPastel:
      return 50; // Pill
    case AppThemeVariant.v7HighContrastRed:
      return 0;
    case AppThemeVariant.v8BlueCorporate:
      return 4;
    case AppThemeVariant.v9RoundedBubbles:
      return 50;
    case AppThemeVariant.v10CardStack3D:
      return 12;
  }
}

/// Get app bar style configuration
AppBarStyle getAppBarStyle(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      );
    case AppThemeVariant.v2ModernGlassblur:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        isTransparent: true,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: 2),
      );
    case AppThemeVariant.v3DarkNeon:
      return AppBarStyle(
        centerTitle: false,
        elevation: 0,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
          fontFamily: 'monospace',
        ),
      );
    case AppThemeVariant.v4MinimalSoft:
      return AppBarStyle(
        centerTitle: false,
        elevation: 0,
        titleStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          letterSpacing: 6,
        ),
      );
    case AppThemeVariant.v6PlayfulPastel:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      );
    case AppThemeVariant.v7HighContrastRed:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      );
    case AppThemeVariant.v8BlueCorporate:
      return AppBarStyle(
        centerTitle: false,
        elevation: 2,
        titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      );
    case AppThemeVariant.v9RoundedBubbles:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      );
    case AppThemeVariant.v10CardStack3D:
      return AppBarStyle(
        centerTitle: true,
        elevation: 0,
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      );
  }
}

/// Get navigation bar style
NavBarStyle getNavBarStyle(AppThemeVariant variant) {
  final primary = getThemePrimaryColor(variant);
  final secondary = getThemeSecondaryColor(variant);
  final tertiary = getThemeTertiaryColor(variant);
  final isDark = isThemeDark(variant);
  
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return NavBarStyle(
        showLabels: true,
        iconSize: 26,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        indicatorType: NavIndicatorType.none,
      );
    case AppThemeVariant.v2ModernGlassblur:
      return NavBarStyle(
        showLabels: false,
        iconSize: 28,
        selectedIconColor: primary,
        unselectedIconColor: Colors.white38,
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        indicatorType: NavIndicatorType.dot,
        isFloating: true,
        borderRadius: 30,
      );
    case AppThemeVariant.v3DarkNeon:
      return NavBarStyle(
        showLabels: true,
        iconSize: 24,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[700]!,
        backgroundColor: Colors.black,
        indicatorType: NavIndicatorType.glow,
        glowColor: primary,
        useCustomIcons: true,
        customActiveIcons: [Icons.radar, Icons.hub, Icons.account_circle],
        customInactiveIcons: [Icons.radar_outlined, Icons.hub_outlined, Icons.account_circle_outlined],
      );
    case AppThemeVariant.v4MinimalSoft:
      return NavBarStyle(
        showLabels: true,
        iconSize: 24,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[400]!,
        backgroundColor: Colors.white,
        indicatorType: NavIndicatorType.underline,
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return NavBarStyle(
        showLabels: true,
        iconSize: 22,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[600]!,
        backgroundColor: Colors.black,
        indicatorType: NavIndicatorType.none,
        labelStyle: const TextStyle(letterSpacing: 2, fontSize: 10),
        useCustomLabels: true,
        customLabels: ['DISCOVER', 'MATCHES', 'PROFILE'],
      );
    case AppThemeVariant.v6PlayfulPastel:
      return NavBarStyle(
        showLabels: true,
        iconSize: 28,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[400]!,
        backgroundColor: Colors.white,
        indicatorType: NavIndicatorType.pill,
        pillColor: primary.withValues(alpha: 0.2),
        useCustomIcons: true,
        customActiveIcons: [Icons.favorite, Icons.chat_bubble, Icons.face],
        customInactiveIcons: [Icons.favorite_border, Icons.chat_bubble_outline, Icons.face_outlined],
      );
    case AppThemeVariant.v7HighContrastRed:
      return NavBarStyle(
        showLabels: true,
        iconSize: 30,
        selectedIconColor: primary,
        unselectedIconColor: Colors.white,
        backgroundColor: Colors.black,
        indicatorType: NavIndicatorType.box,
        boxColor: primary,
      );
    case AppThemeVariant.v8BlueCorporate:
      return NavBarStyle(
        showLabels: true,
        iconSize: 24,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[500]!,
        backgroundColor: Colors.white,
        indicatorType: NavIndicatorType.underline,
        elevation: 4,
      );
    case AppThemeVariant.v9RoundedBubbles:
      return NavBarStyle(
        showLabels: false,
        iconSize: 26,
        selectedIconColor: Colors.white,
        unselectedIconColor: Colors.grey[500]!,
        backgroundColor: Colors.white,
        indicatorType: NavIndicatorType.bubble,
        bubbleColor: primary,
        isFloating: true,
        borderRadius: 40,
      );
    case AppThemeVariant.v10CardStack3D:
      return NavBarStyle(
        showLabels: true,
        iconSize: 26,
        selectedIconColor: primary,
        unselectedIconColor: Colors.grey[600]!,
        backgroundColor: const Color(0xFF1A0A2E),
        indicatorType: NavIndicatorType.glow,
        glowColor: primary,
      );
  }
}

/// Get card padding for swipe cards
EdgeInsets getCardPadding(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    case AppThemeVariant.v2ModernGlassblur:
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    case AppThemeVariant.v3DarkNeon:
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    case AppThemeVariant.v4MinimalSoft:
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    case AppThemeVariant.v6PlayfulPastel:
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    case AppThemeVariant.v7HighContrastRed:
      return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    case AppThemeVariant.v8BlueCorporate:
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    case AppThemeVariant.v9RoundedBubbles:
      return const EdgeInsets.symmetric(horizontal: 28, vertical: 20);
    case AppThemeVariant.v10CardStack3D:
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }
}

/// Get gradient for buttons
LinearGradient getButtonGradient(AppThemeVariant variant) {
  final primary = getThemePrimaryColor(variant);
  final secondary = getThemeSecondaryColor(variant);
  
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return LinearGradient(
        colors: [primary, const Color(0xFFFF8A80)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case AppThemeVariant.v2ModernGlassblur:
      return LinearGradient(
        colors: [primary.withValues(alpha: 0.8), secondary.withValues(alpha: 0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case AppThemeVariant.v3DarkNeon:
      return const LinearGradient(
        colors: [Color(0xFF00FFFF), Color(0xFFFF00FF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    case AppThemeVariant.v4MinimalSoft:
      return LinearGradient(
        colors: [primary, primary],
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const LinearGradient(
        colors: [Color(0xFFD4AF37), Color(0xFFB8860B), Color(0xFFD4AF37)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case AppThemeVariant.v6PlayfulPastel:
      return const LinearGradient(
        colors: [Color(0xFFFF6B9D), Color(0xFFFECA57), Color(0xFF74B9FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case AppThemeVariant.v7HighContrastRed:
      return const LinearGradient(
        colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
      );
    case AppThemeVariant.v8BlueCorporate:
      return LinearGradient(
        colors: [primary, const Color(0xFF106EBE)],
      );
    case AppThemeVariant.v9RoundedBubbles:
      return LinearGradient(
        colors: [primary, const Color(0xFF81ECEC)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    case AppThemeVariant.v10CardStack3D:
      return const LinearGradient(
        colors: [Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFF6366F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}

/// Get info texts for swipe screen
SwipeScreenTexts getSwipeScreenTexts(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return SwipeScreenTexts(
        title: 'Discover',
        emptyTitle: 'No more profiles',
        emptySubtitle: 'Check back later for new people!',
        refreshText: 'Refresh',
        likeText: 'LIKE',
        nopeText: 'NOPE',
        superLikeText: 'SUPER',
      );
    case AppThemeVariant.v2ModernGlassblur:
      return SwipeScreenTexts(
        title: 'explore',
        emptyTitle: 'All caught up',
        emptySubtitle: 'New connections coming soon',
        refreshText: 'Refresh',
        likeText: 'YES',
        nopeText: 'PASS',
        superLikeText: 'WOW',
      );
    case AppThemeVariant.v3DarkNeon:
      return SwipeScreenTexts(
        title: '> SCAN_',
        emptyTitle: '// NO_SIGNAL',
        emptySubtitle: 'SEARCHING FOR CONNECTIONS...',
        refreshText: 'RESCAN',
        likeText: 'CONNECT',
        nopeText: 'REJECT',
        superLikeText: 'BOOST',
      );
    case AppThemeVariant.v4MinimalSoft:
      return SwipeScreenTexts(
        title: 'People',
        emptyTitle: 'Nothing here',
        emptySubtitle: 'Come back soon',
        refreshText: 'Try again',
        likeText: 'Yes',
        nopeText: 'No',
        superLikeText: 'Love',
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return SwipeScreenTexts(
        title: 'CURATED',
        emptyTitle: 'Awaiting Selection',
        emptySubtitle: 'Our curators are finding your match',
        refreshText: 'REFRESH',
        likeText: 'INTERESTED',
        nopeText: 'DECLINE',
        superLikeText: 'VIP',
      );
    case AppThemeVariant.v6PlayfulPastel:
      return SwipeScreenTexts(
        title: 'Find Friends! 💫',
        emptyTitle: 'No one here yet 😢',
        emptySubtitle: 'Come back later for more friends!',
        refreshText: 'Try Again! 🔄',
        likeText: 'YAY! 💕',
        nopeText: 'NAH 👋',
        superLikeText: 'OMG! ⭐',
      );
    case AppThemeVariant.v7HighContrastRed:
      return SwipeScreenTexts(
        title: 'SWIPE!',
        emptyTitle: 'EMPTY',
        emptySubtitle: 'NO MORE PEOPLE',
        refreshText: 'RELOAD',
        likeText: 'YES!',
        nopeText: 'NO!',
        superLikeText: 'FIRE!',
      );
    case AppThemeVariant.v8BlueCorporate:
      return SwipeScreenTexts(
        title: 'Connect',
        emptyTitle: 'No connections available',
        emptySubtitle: 'Please check back later',
        refreshText: 'Reload',
        likeText: 'Connect',
        nopeText: 'Skip',
        superLikeText: 'Priority',
      );
    case AppThemeVariant.v9RoundedBubbles:
      return SwipeScreenTexts(
        title: 'Discover ~',
        emptyTitle: 'All done!',
        emptySubtitle: 'More bubbles coming soon~',
        refreshText: 'Pop more!',
        likeText: 'Love~',
        nopeText: 'Next~',
        superLikeText: 'Wow!',
      );
    case AppThemeVariant.v10CardStack3D:
      return SwipeScreenTexts(
        title: '✦ DISCOVER',
        emptyTitle: 'Void Empty',
        emptySubtitle: 'Scanning the cosmos...',
        refreshText: 'Scan Again',
        likeText: 'MATCH',
        nopeText: 'SKIP',
        superLikeText: 'STAR',
      );
  }
}

/// Get empty state icon
IconData getEmptyStateIcon(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return Icons.search_off;
    case AppThemeVariant.v2ModernGlassblur:
      return Icons.blur_on;
    case AppThemeVariant.v3DarkNeon:
      return Icons.wifi_tethering_off;
    case AppThemeVariant.v4MinimalSoft:
      return Icons.inbox_outlined;
    case AppThemeVariant.v5LuxuryGoldBlack:
      return Icons.diamond_outlined;
    case AppThemeVariant.v6PlayfulPastel:
      return Icons.sentiment_dissatisfied;
    case AppThemeVariant.v7HighContrastRed:
      return Icons.error_outline;
    case AppThemeVariant.v8BlueCorporate:
      return Icons.people_outline;
    case AppThemeVariant.v9RoundedBubbles:
      return Icons.bubble_chart;
    case AppThemeVariant.v10CardStack3D:
      return Icons.auto_awesome;
  }
}

/// Build ThemeData for variant
ThemeData buildThemeForVariant(AppThemeVariant variant) {
  final primaryColor = getThemePrimaryColor(variant);
  final secondaryColor = getThemeSecondaryColor(variant);
  final backgroundColor = getThemeBackgroundColor(variant);
  final surfaceColor = getThemeSurfaceColor(variant);
  final isDark = isThemeDark(variant);
  final cardRadius = getCardBorderRadius(variant);
  final buttonRadius = getButtonBorderRadius(variant);
  final appBarStyle = getAppBarStyle(variant);
  final textColor = isDark ? Colors.white : Colors.black87;

  return ThemeData(
    useMaterial3: true,
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: isDark
        ? ColorScheme.dark(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: surfaceColor,
          )
        : ColorScheme.light(
            primary: primaryColor,
            secondary: secondaryColor,
            surface: surfaceColor,
          ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarStyle.isTransparent ? Colors.transparent : backgroundColor,
      elevation: appBarStyle.elevation,
      centerTitle: appBarStyle.centerTitle,
      titleTextStyle: appBarStyle.titleStyle.copyWith(color: textColor),
      iconTheme: IconThemeData(color: textColor),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: variant == AppThemeVariant.v2ModernGlassblur ? 0 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        side: variant == AppThemeVariant.v5LuxuryGoldBlack
            ? const BorderSide(color: Color(0xFFD4AF37), width: 1)
            : variant == AppThemeVariant.v3DarkNeon
                ? const BorderSide(color: Color(0xFF00FFFF), width: 1)
                : BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: isDark || variant == AppThemeVariant.v4MinimalSoft 
            ? Colors.white 
            : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
          side: variant == AppThemeVariant.v3DarkNeon
              ? const BorderSide(color: Color(0xFF00FFFF), width: 2)
              : BorderSide.none,
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 2 : 0,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        borderSide: variant == AppThemeVariant.v3DarkNeon
            ? const BorderSide(color: Color(0xFF00FFFF))
            : BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: isDark ? Colors.grey : Colors.grey[600],
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: variant == AppThemeVariant.v6PlayfulPastel ? 14 : 12,
        letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 1 : 0,
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: variant == AppThemeVariant.v9RoundedBubbles
          ? const CircleBorder()
          : variant == AppThemeVariant.v3DarkNeon || variant == AppThemeVariant.v7HighContrastRed
              ? const RoundedRectangleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: textColor,
        fontWeight: variant == AppThemeVariant.v7HighContrastRed ? FontWeight.w900 : FontWeight.bold,
        letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 2 : 0,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontWeight: variant == AppThemeVariant.v7HighContrastRed ? FontWeight.w900 : FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor.withValues(alpha: 0.8)),
    ),
  );
}

// Helper classes
class AppBarStyle {
  final bool centerTitle;
  final double elevation;
  final TextStyle titleStyle;
  final bool isTransparent;

  AppBarStyle({
    this.centerTitle = true,
    this.elevation = 0,
    required this.titleStyle,
    this.isTransparent = false,
  });
}

enum NavIndicatorType { none, dot, glow, underline, pill, box, bubble }

class NavBarStyle {
  final bool showLabels;
  final double iconSize;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color backgroundColor;
  final NavIndicatorType indicatorType;
  final Color? glowColor;
  final Color? pillColor;
  final Color? boxColor;
  final Color? bubbleColor;
  final bool isFloating;
  final double borderRadius;
  final double elevation;
  final TextStyle? labelStyle;
  final bool useCustomIcons;
  final List<IconData>? customActiveIcons;
  final List<IconData>? customInactiveIcons;
  final bool useCustomLabels;
  final List<String>? customLabels;

  NavBarStyle({
    this.showLabels = true,
    this.iconSize = 24,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.backgroundColor,
    this.indicatorType = NavIndicatorType.none,
    this.glowColor,
    this.pillColor,
    this.boxColor,
    this.bubbleColor,
    this.isFloating = false,
    this.borderRadius = 0,
    this.elevation = 0,
    this.labelStyle,
    this.useCustomIcons = false,
    this.customActiveIcons,
    this.customInactiveIcons,
    this.useCustomLabels = false,
    this.customLabels,
  });
}

class SwipeScreenTexts {
  final String title;
  final String emptyTitle;
  final String emptySubtitle;
  final String refreshText;
  final String likeText;
  final String nopeText;
  final String superLikeText;

  SwipeScreenTexts({
    required this.title,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.refreshText,
    required this.likeText,
    required this.nopeText,
    required this.superLikeText,
  });
}
