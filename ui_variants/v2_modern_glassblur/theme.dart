import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V2 Modern Glassblur - Theme Configuration
class V2Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: V2Colors.primary,
      scaffoldBackgroundColor: V2Colors.background,
      colorScheme: const ColorScheme.dark(
        primary: V2Colors.primary,
        secondary: V2Colors.secondary,
        surface: V2Colors.surface,
        error: V2Colors.error,
        onPrimary: V2Colors.textOnPrimary,
        onSecondary: V2Colors.textOnPrimary,
        onSurface: V2Colors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: V2Fonts.titleLarge,
        iconTheme: IconThemeData(color: V2Colors.textPrimary),
      ),
      cardTheme: CardTheme(
        color: V2Colors.surface.withOpacity(0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: V2Colors.primary,
          foregroundColor: V2Colors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: V2Fonts.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: V2Colors.textPrimary,
          side: BorderSide(color: V2Colors.glassBorder, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: V2Colors.glassWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: V2Colors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: V2Colors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: V2Colors.primary, width: 2),
        ),
        hintStyle: V2Fonts.bodyMedium.copyWith(color: V2Colors.textMuted),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: V2Colors.primary,
        unselectedItemColor: V2Colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}

