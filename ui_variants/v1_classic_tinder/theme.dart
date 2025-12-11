import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V1 Classic Tinder - Theme Configuration
class V1Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: V1Colors.primary,
      scaffoldBackgroundColor: V1Colors.background,
      colorScheme: const ColorScheme.light(
        primary: V1Colors.primary,
        secondary: V1Colors.secondary,
        surface: V1Colors.surface,
        error: V1Colors.error,
        onPrimary: V1Colors.textOnPrimary,
        onSecondary: V1Colors.textOnPrimary,
        onSurface: V1Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: V1Colors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V1Fonts.titleLarge,
        iconTheme: IconThemeData(color: V1Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V1Colors.card,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V1Colors.primary,
          foregroundColor: V1Colors.textOnPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: V1Fonts.labelLarge.copyWith(color: V1Colors.textOnPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V1Colors.primary,
          side: const BorderSide(color: V1Colors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V1Colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: V1Colors.primary, width: 2),
        ),
        hintStyle: V1Fonts.bodyMedium.copyWith(color: V1Colors.textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: V1Colors.background,
        selectedItemColor: V1Colors.primary,
        unselectedItemColor: V1Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}

