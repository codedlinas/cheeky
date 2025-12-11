import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V3 Dark Neon - Theme Configuration
class V3Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: V3Colors.primary,
      scaffoldBackgroundColor: V3Colors.background,
      colorScheme: const ColorScheme.dark(
        primary: V3Colors.primary,
        secondary: V3Colors.secondary,
        surface: V3Colors.surface,
        error: V3Colors.error,
        onPrimary: V3Colors.textPrimary,
        onSecondary: V3Colors.textPrimary,
        onSurface: V3Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V3Fonts.titleLarge,
        iconTheme: IconThemeData(color: V3Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V3Colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: V3Colors.primary, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: V3Colors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: V3Colors.primary, width: 2),
          ),
          textStyle: V3Fonts.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V3Colors.secondary,
          side: const BorderSide(color: V3Colors.secondary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V3Colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: V3Colors.primary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: V3Colors.primary.withOpacity(0.5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: V3Colors.primary, width: 2),
        ),
        hintStyle: V3Fonts.bodyMedium.copyWith(color: V3Colors.textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: V3Colors.background,
        selectedItemColor: V3Colors.primary,
        unselectedItemColor: V3Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}

