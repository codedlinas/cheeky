import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class V10Theme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: V10Colors.primary,
    scaffoldBackgroundColor: V10Colors.background,
    colorScheme: const ColorScheme.dark(primary: V10Colors.primary, secondary: V10Colors.secondary, surface: V10Colors.surface, error: V10Colors.error, onPrimary: V10Colors.textOnPrimary, onSurface: V10Colors.textPrimary),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true, titleTextStyle: V10Fonts.titleLarge, iconTheme: IconThemeData(color: V10Colors.textPrimary)),
    cardTheme: CardTheme(color: V10Colors.surface, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: V10Colors.primary, foregroundColor: V10Colors.textOnPrimary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: V10Colors.surfaceLight, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: V10Colors.primary, width: 2))),
  );
}

