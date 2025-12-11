import 'package:flutter/material.dart';
import 'colors.dart';

/// V6 Playful Pastel - Typography
class V6Fonts {
  static const String fontFamily = 'Quicksand';
  static const String fontFamilyAlt = 'Fredoka';
  
  // Display Styles - Fun and bouncy
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: V6Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: V6Colors.textPrimary,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: V6Colors.textPrimary,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: V6Colors.textPrimary,
  );
  
  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: V6Colors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: V6Colors.textPrimary,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: V6Colors.textPrimary,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: V6Colors.textSecondary,
    height: 1.5,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: V6Colors.textPrimary,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: V6Colors.textSecondary,
  );
  
  // Card Styles
  static const TextStyle cardName = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  
  static const TextStyle cardAge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  
  static const TextStyle cardBio = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.4,
  );
}

