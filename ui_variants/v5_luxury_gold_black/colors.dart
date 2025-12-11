import 'package:flutter/material.dart';

/// V5 Luxury Gold Black - Color Palette
class V5Colors {
  // Gold Colors
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFC9A227);
  static const Color goldMuted = Color(0xFFB8972D);
  
  // Black Colors
  static const Color background = Color(0xFF0D0D0D);
  static const Color backgroundAlt = Color(0xFF000000);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF252525);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF707070);
  static const Color textGold = Color(0xFFD4AF37);
  
  // Status Colors - luxurious tones
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFCF6679);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
  
  // Swipe Colors
  static const Color likeColor = Color(0xFF4CAF50);
  static const Color passColor = Color(0xFFCF6679);
  static const Color superLikeColor = Color(0xFFD4AF37);
  
  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, goldLight, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static LinearGradient get goldShimmer => LinearGradient(
    colors: [
      gold.withOpacity(0.0),
      gold.withOpacity(0.5),
      gold.withOpacity(0.0),
    ],
    stops: const [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Luxury Shadows
  static List<BoxShadow> get luxuryShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 30,
      offset: const Offset(0, 15),
    ),
    BoxShadow(
      color: gold.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 5),
    ),
  ];
  
  static List<BoxShadow> get goldGlow => [
    BoxShadow(
      color: gold.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];
}

/// Gold border decoration
class GoldBorderDecoration extends BoxDecoration {
  GoldBorderDecoration({
    double borderRadius = 16,
    double borderWidth = 1,
    bool hasShadow = true,
  }) : super(
    color: V5Colors.surface,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: V5Colors.gold.withOpacity(0.3), width: borderWidth),
    boxShadow: hasShadow ? V5Colors.luxuryShadow : null,
  );
}

