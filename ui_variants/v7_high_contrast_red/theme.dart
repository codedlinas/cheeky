import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V7 High Contrast Red - Theme Configuration
class V7Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: V7Colors.primary,
      scaffoldBackgroundColor: V7Colors.background,
      colorScheme: const ColorScheme.light(
        primary: V7Colors.primary,
        secondary: V7Colors.secondary,
        surface: V7Colors.surface,
        error: V7Colors.error,
        onPrimary: V7Colors.textOnPrimary,
        onSecondary: V7Colors.textOnPrimary,
        onSurface: V7Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: V7Colors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V7Fonts.titleLarge,
        iconTheme: IconThemeData(color: V7Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V7Colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V7Colors.primary,
          foregroundColor: V7Colors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          textStyle: V7Fonts.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V7Colors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: V7Colors.textPrimary, width: 2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: V7Colors.primary, width: 2)),
      ),
    );
  }
}

