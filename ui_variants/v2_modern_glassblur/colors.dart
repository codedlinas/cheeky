import 'package:flutter/material.dart';
import 'dart:ui';

/// V2 Modern Glassblur - Color Palette
class V2Colors {
  // Primary Colors
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color primaryDark = Color(0xFF5B4BD4);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFA29BFE);
  static const Color accent = Color(0xFF00CEC9);
  static const Color accentAlt = Color(0xFF74B9FF);
  
  // Background Colors
  static const Color background = Color(0xFF1A1A2E);
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color surface = Color(0xFF252542);
  
  // Glass Colors
  static Color glassWhite = Colors.white.withOpacity(0.1);
  static Color glassBorder = Colors.white.withOpacity(0.2);
  static Color glassHighlight = Colors.white.withOpacity(0.05);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textMuted = Color(0xFF707090);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF74B9FF);
  
  // Swipe Colors
  static const Color likeColor = Color(0xFF00B894);
  static const Color passColor = Color(0xFFFF6B6B);
  static const Color superLikeColor = Color(0xFF00CEC9);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8E7CF3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static LinearGradient get glassGradient => LinearGradient(
    colors: [
      Colors.white.withOpacity(0.15),
      Colors.white.withOpacity(0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadows
  static List<BoxShadow> get glassShadow => [
    BoxShadow(
      color: primary.withOpacity(0.2),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];
  
  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: primary.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];
}

/// Glass effect decoration
class GlassDecoration extends BoxDecoration {
  GlassDecoration({
    double borderRadius = 20,
    bool hasBorder = true,
  }) : super(
    gradient: V2Colors.glassGradient,
    borderRadius: BorderRadius.circular(borderRadius),
    border: hasBorder ? Border.all(color: V2Colors.glassBorder, width: 1) : null,
    boxShadow: V2Colors.glassShadow,
  );
}

