import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V6 Playful Pastel - Theme Configuration
class V6Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: V6Colors.primary,
      scaffoldBackgroundColor: V6Colors.background,
      colorScheme: const ColorScheme.light(
        primary: V6Colors.primary,
        secondary: V6Colors.secondary,
        surface: V6Colors.surface,
        error: V6Colors.error,
        onPrimary: V6Colors.textOnPrimary,
        onSecondary: V6Colors.textOnPrimary,
        onSurface: V6Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V6Fonts.titleLarge,
        iconTheme: IconThemeData(color: V6Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V6Colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V6Colors.primary,
          foregroundColor: V6Colors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          textStyle: V6Fonts.labelLarge.copyWith(color: V6Colors.textOnPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V6Colors.primary,
          side: const BorderSide(color: V6Colors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V6Colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: V6Colors.primary, width: 2),
        ),
        hintStyle: V6Fonts.bodyMedium.copyWith(color: V6Colors.textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: V6Colors.surface,
        selectedItemColor: V6Colors.primary,
        unselectedItemColor: V6Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}

