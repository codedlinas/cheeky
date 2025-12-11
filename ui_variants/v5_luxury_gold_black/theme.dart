import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V5 Luxury Gold Black - Theme Configuration
class V5Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: V5Colors.gold,
      scaffoldBackgroundColor: V5Colors.background,
      colorScheme: const ColorScheme.dark(
        primary: V5Colors.gold,
        secondary: V5Colors.goldLight,
        surface: V5Colors.surface,
        error: V5Colors.error,
        onPrimary: V5Colors.background,
        onSecondary: V5Colors.background,
        onSurface: V5Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V5Fonts.titleLarge,
        iconTheme: IconThemeData(color: V5Colors.gold),
      ),
      cardTheme: CardTheme(
        color: V5Colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: V5Colors.gold.withOpacity(0.2), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V5Colors.gold,
          foregroundColor: V5Colors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: V5Fonts.labelLarge.copyWith(color: V5Colors.background),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V5Colors.gold,
          side: const BorderSide(color: V5Colors.gold, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V5Colors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: V5Colors.gold.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: V5Colors.gold.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: V5Colors.gold, width: 1),
        ),
        hintStyle: V5Fonts.bodyMedium.copyWith(color: V5Colors.textMuted),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: V5Colors.surface,
        selectedItemColor: V5Colors.gold,
        unselectedItemColor: V5Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: V5Colors.gold.withOpacity(0.2),
        thickness: 1,
      ),
    );
  }
}

