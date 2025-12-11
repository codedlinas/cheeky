import 'package:flutter/material.dart';
import 'colors.dart';

/// V3 Dark Neon - Typography
class V3Fonts {
  static const String fontFamily = 'Orbitron';
  static const String fontFamilyAlt = 'Rajdhani';
  
  // Display Styles - Futuristic headers
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: V3Colors.textPrimary,
    letterSpacing: 4,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: V3Colors.textPrimary,
    letterSpacing: 3,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: V3Colors.textPrimary,
    letterSpacing: 2,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: V3Colors.textPrimary,
    letterSpacing: 1.5,
  );
  
  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: V3Colors.textPrimary,
    letterSpacing: 1,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: V3Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: V3Colors.textPrimary,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: V3Colors.textSecondary,
    height: 1.5,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: V3Colors.textPrimary,
    letterSpacing: 2,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: V3Colors.textSecondary,
    letterSpacing: 1,
  );
  
  // Card Styles with neon effect
  static TextStyle cardName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 2,
    shadows: [
      Shadow(color: V3Colors.primary.withOpacity(0.8), blurRadius: 10),
    ],
  );
  
  static const TextStyle cardAge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 24,
    fontWeight: FontWeight.w300,
    color: Colors.white70,
  );
  
  static const TextStyle cardBio = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.4,
  );
  
  // Neon text style helper
  static TextStyle neonText(Color glowColor, {double fontSize = 16}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 2,
    shadows: [
      Shadow(color: glowColor, blurRadius: 10),
      Shadow(color: glowColor.withOpacity(0.5), blurRadius: 20),
    ],
  );
}

