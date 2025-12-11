import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V4 Minimal Soft - Theme Configuration
class V4Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: V4Colors.primary,
      scaffoldBackgroundColor: V4Colors.background,
      colorScheme: const ColorScheme.light(
        primary: V4Colors.primary,
        secondary: V4Colors.secondary,
        surface: V4Colors.surface,
        error: V4Colors.error,
        onPrimary: V4Colors.textOnPrimary,
        onSecondary: V4Colors.textPrimary,
        onSurface: V4Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: V4Colors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V4Fonts.titleLarge,
        iconTheme: IconThemeData(color: V4Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V4Colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: V4Colors.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V4Colors.primary,
          foregroundColor: V4Colors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: V4Fonts.labelLarge.copyWith(color: V4Colors.textOnPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V4Colors.primary,
          side: const BorderSide(color: V4Colors.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V4Colors.surfaceAlt,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: V4Colors.borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: V4Colors.primary, width: 1),
        ),
        hintStyle: V4Fonts.bodyMedium.copyWith(color: V4Colors.textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: V4Colors.surface,
        selectedItemColor: V4Colors.primary,
        unselectedItemColor: V4Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: V4Colors.border,
        thickness: 1,
      ),
    );
  }
}

