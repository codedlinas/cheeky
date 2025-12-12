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

/// Get card border radius
double getCardBorderRadius(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return 16;
    case AppThemeVariant.v2ModernGlassblur:
      return 24;
    case AppThemeVariant.v3DarkNeon:
      return 4; // Sharp edges
    case AppThemeVariant.v4MinimalSoft:
      return 8;
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 0; // No radius - sharp luxury
    case AppThemeVariant.v6PlayfulPastel:
      return 32; // Very rounded
    case AppThemeVariant.v7HighContrastRed:
      return 0; // Sharp
    case AppThemeVariant.v8BlueCorporate:
      return 4;
    case AppThemeVariant.v9RoundedBubbles:
      return 50; // Super round
    case AppThemeVariant.v10CardStack3D:
      return 20;
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

/// Get special border for variant (neon glow, gold border, etc)
BoxDecoration? getSpecialCardDecoration(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v3DarkNeon:
      return BoxDecoration(
        border: Border.all(color: const Color(0xFF00FFFF), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFFF).withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return BoxDecoration(
        border: Border.all(color: const Color(0xFFD4AF37), width: 1),
      );
    case AppThemeVariant.v7HighContrastRed:
      return BoxDecoration(
        border: Border.all(color: Colors.red, width: 3),
      );
    default:
      return null;
  }
}

/// Get gradient for buttons
LinearGradient getButtonGradient(AppThemeVariant variant) {
  final primary = getThemePrimaryColor(variant);
  final secondary = getThemeSecondaryColor(variant);
  
  switch (variant) {
    case AppThemeVariant.v3DarkNeon:
      return const LinearGradient(
        colors: [Color(0xFF00FFFF), Color(0xFFFF00FF)],
      );
    case AppThemeVariant.v5LuxuryGoldBlack:
      return const LinearGradient(
        colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
      );
    case AppThemeVariant.v6PlayfulPastel:
      return const LinearGradient(
        colors: [Color(0xFFFF6B9D), Color(0xFFFECA57), Color(0xFF48DBFB)],
      );
    case AppThemeVariant.v10CardStack3D:
      return const LinearGradient(
        colors: [Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFF6366F1)],
      );
    default:
      return LinearGradient(colors: [primary, secondary]);
  }
}

/// Get font family suggestion
String getFontFamily(AppThemeVariant variant) {
  switch (variant) {
    case AppThemeVariant.v1ClassicTinder:
      return 'SF Pro Display';
    case AppThemeVariant.v2ModernGlassblur:
      return 'Poppins';
    case AppThemeVariant.v3DarkNeon:
      return 'Orbitron';
    case AppThemeVariant.v4MinimalSoft:
      return 'Inter';
    case AppThemeVariant.v5LuxuryGoldBlack:
      return 'Playfair Display';
    case AppThemeVariant.v6PlayfulPastel:
      return 'Quicksand';
    case AppThemeVariant.v7HighContrastRed:
      return 'Impact';
    case AppThemeVariant.v8BlueCorporate:
      return 'Segoe UI';
    case AppThemeVariant.v9RoundedBubbles:
      return 'Nunito';
    case AppThemeVariant.v10CardStack3D:
      return 'Space Grotesk';
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
        fontSize: variant == AppThemeVariant.v5LuxuryGoldBlack ? 24 : 20,
        fontWeight: variant == AppThemeVariant.v7HighContrastRed 
            ? FontWeight.w900 
            : FontWeight.bold,
        letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 2 : 0,
      ),
      iconTheme: IconThemeData(color: textColor),
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: variant == AppThemeVariant.v2ModernGlassblur ? 0 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        side: variant == AppThemeVariant.v5LuxuryGoldBlack
            ? const BorderSide(color: Color(0xFFD4AF37), width: 1)
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
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
    ),
  );
}
