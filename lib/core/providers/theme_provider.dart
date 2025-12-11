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
      return 'Modern Glassblur';
    case AppThemeVariant.v3DarkNeon:
      return 'Dark Neon';
    case AppThemeVariant.v4MinimalSoft:
      return 'Minimal Soft';
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 'Luxury Gold';
    case AppThemeVariant.v6PlayfulPastel:
      return 'Playful Pastel';
    case AppThemeVariant.v7HighContrastRed:
      return 'High Contrast Red';
    case AppThemeVariant.v8BlueCorporate:
      return 'Corporate Blue';
    case AppThemeVariant.v9RoundedBubbles:
      return 'Rounded Bubbles';
    case AppThemeVariant.v10CardStack3D:
      return '3D Card Stack';
  }
}

/// Get primary color for each theme
Color getThemePrimaryColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFFFF4F70); // Cheeky pink
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF6366F1); // Indigo
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF00FFFF); // Cyan
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFF64748B); // Slate
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFFD4AF37); // Gold
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFF9EC4); // Pink pastel
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFFDC2626); // Red
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFF0078D4); // Microsoft blue
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFF06B6D4); // Cyan
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFF8B5CF6); // Purple
  }
}

/// Get secondary color for each theme
Color getThemeSecondaryColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFF8A2BE2);
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFFA855F7);
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFFFF00FF);
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFF94A3B8);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFFF5E6CC);
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFB4A7FF);
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFF00A4EF);
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFF472B6);
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFFEC4899);
  }
}

/// Get background color for each theme
Color getThemeBackgroundColor(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return const Color(0xFF0A0A0F);
    case AppThemeVariant.v2ModernGlassblur:
      return const Color(0xFF0F0F1A);
    case AppThemeVariant.v3DarkNeon:
      return const Color(0xFF000000);
    case AppThemeVariant.v4MinimalSoft:
      return const Color(0xFFF8FAFC);
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const Color(0xFF0A0A0A);
    case AppThemeVariant.v6PlayfulPastel:
      return const Color(0xFFFFF5F7);
    case AppThemeVariant.v7HighContrastRed:
      return const Color(0xFF000000);
    case AppThemeVariant.v8BlueCorporate:
      return const Color(0xFFFFFFFF);
    case AppThemeVariant.v9RoundedBubbles:
      return const Color(0xFFF0FDFA);
    case AppThemeVariant.v10CardStack3D:
      return const Color(0xFF0C0A1D);
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

/// Build ThemeData for variant
ThemeData buildThemeForVariant(AppThemeVariant variant) {
  final primaryColor = getThemePrimaryColor(variant);
  final secondaryColor = getThemeSecondaryColor(variant);
  final backgroundColor = getThemeBackgroundColor(variant);
  final isDark = isThemeDark(variant);
  final surfaceColor = isDark 
      ? Color.lerp(backgroundColor, Colors.white, 0.08)! 
      : Color.lerp(backgroundColor, Colors.black, 0.04)!;
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
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textColor),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: isDark ? Colors.grey : Colors.grey[600],
      type: BottomNavigationBarType.fixed,
    ),
  );
}

