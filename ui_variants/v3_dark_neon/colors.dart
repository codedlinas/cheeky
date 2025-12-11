import 'package:flutter/material.dart';

/// V3 Dark Neon - Color Palette
class V3Colors {
  // Primary Neon Colors
  static const Color primary = Color(0xFFFF00FF);      // Magenta
  static const Color primaryLight = Color(0xFFFF66FF);
  static const Color primaryDark = Color(0xFFCC00CC);
  
  // Secondary Neon Colors
  static const Color secondary = Color(0xFF00FFFF);    // Cyan
  static const Color secondaryLight = Color(0xFF66FFFF);
  static const Color accent = Color(0xFFFFE500);       // Yellow Neon
  static const Color accentAlt = Color(0xFFFF3366);    // Pink Neon
  
  // Background Colors
  static const Color background = Color(0xFF0A0A0A);
  static const Color backgroundAlt = Color(0xFF050505);
  static const Color surface = Color(0xFF151515);
  static const Color surfaceLight = Color(0xFF1F1F1F);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFAAAAAA);
  static const Color textMuted = Color(0xFF666666);
  static const Color textNeon = Color(0xFFFF00FF);
  
  // Status Colors
  static const Color success = Color(0xFF00FF88);      // Green Neon
  static const Color error = Color(0xFFFF3366);        // Red Neon
  static const Color warning = Color(0xFFFFE500);      // Yellow Neon
  static const Color info = Color(0xFF00FFFF);         // Cyan Neon
  
  // Swipe Colors
  static const Color likeColor = Color(0xFF00FF88);
  static const Color passColor = Color(0xFFFF3366);
  static const Color superLikeColor = Color(0xFF00FFFF);
  
  // Neon Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF33CC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient neonRainbow = LinearGradient(
    colors: [primary, secondary, accent, accentAlt],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [surface, surfaceLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Neon Glow Effects
  static List<BoxShadow> neonGlow(Color color, {double intensity = 1.0}) => [
    BoxShadow(
      color: color.withOpacity(0.6 * intensity),
      blurRadius: 10 * intensity,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: color.withOpacity(0.4 * intensity),
      blurRadius: 20 * intensity,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: color.withOpacity(0.2 * intensity),
      blurRadius: 40 * intensity,
      spreadRadius: 4,
    ),
  ];
  
  static List<BoxShadow> get primaryGlow => neonGlow(primary);
  static List<BoxShadow> get secondaryGlow => neonGlow(secondary);
  static List<BoxShadow> get successGlow => neonGlow(success);
  static List<BoxShadow> get errorGlow => neonGlow(error);
  
  // Card Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: primary.withOpacity(0.1),
      blurRadius: 30,
      spreadRadius: -5,
    ),
  ];
}

/// Neon border decoration
class NeonBorderDecoration extends BoxDecoration {
  NeonBorderDecoration({
    Color color = V3Colors.primary,
    double borderRadius = 16,
    double borderWidth = 2,
    bool hasGlow = true,
  }) : super(
    color: V3Colors.surface,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: color, width: borderWidth),
    boxShadow: hasGlow ? V3Colors.neonGlow(color, intensity: 0.5) : null,
  );
}

