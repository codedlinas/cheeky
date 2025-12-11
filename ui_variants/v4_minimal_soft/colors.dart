import 'package:flutter/material.dart';

/// V4 Minimal Soft - Color Palette
class V4Colors {
  // Primary Colors
  static const Color primary = Color(0xFF5C6BC0);
  static const Color primaryLight = Color(0xFF7986CB);
  static const Color primaryDark = Color(0xFF3F51B5);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF9FA8DA);
  static const Color accent = Color(0xFFE8EAF6);
  
  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF5F5F5);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C2C2C);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textMuted = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF66BB6A);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
  
  // Swipe Colors
  static const Color likeColor = Color(0xFF66BB6A);
  static const Color passColor = Color(0xFFE57373);
  static const Color superLikeColor = Color(0xFF5C6BC0);
  
  // Borders
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  
  // Gradients - minimal, subtle
  static const LinearGradient softGradient = LinearGradient(
    colors: [Color(0xFFFAFAFA), Color(0xFFF5F5F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient cardOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0x40000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadows - very subtle
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
}

