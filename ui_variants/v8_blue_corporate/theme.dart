import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class V8Theme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: V8Colors.primary,
      scaffoldBackgroundColor: V8Colors.background,
      colorScheme: const ColorScheme.light(primary: V8Colors.primary, secondary: V8Colors.secondary, surface: V8Colors.surface, error: V8Colors.error, onPrimary: V8Colors.textOnPrimary, onSurface: V8Colors.textPrimary),
      appBarTheme: const AppBarTheme(backgroundColor: V8Colors.background, elevation: 0, centerTitle: false, titleTextStyle: V8Fonts.titleLarge, iconTheme: IconThemeData(color: V8Colors.textPrimary)),
      cardTheme: CardTheme(color: V8Colors.surface, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: V8Colors.primary, foregroundColor: V8Colors.textOnPrimary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: V8Colors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: V8Colors.border)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: V8Colors.primary, width: 2))),
    );
  }
}

