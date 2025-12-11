import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class V9Theme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: V9Colors.primary,
    scaffoldBackgroundColor: V9Colors.background,
    colorScheme: const ColorScheme.light(primary: V9Colors.primary, secondary: V9Colors.secondary, surface: V9Colors.surface, error: V9Colors.error, onPrimary: V9Colors.textOnPrimary, onSurface: V9Colors.textPrimary),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, centerTitle: true, titleTextStyle: V9Fonts.titleLarge, iconTheme: IconThemeData(color: V9Colors.textPrimary)),
    cardTheme: CardTheme(color: V9Colors.surface, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: V9Colors.primary, foregroundColor: V9Colors.textOnPrimary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
    inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: V9Colors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: V9Colors.primary, width: 2))),
  );
}

