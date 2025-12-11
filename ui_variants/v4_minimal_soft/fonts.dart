import 'package:flutter/material.dart';
import 'colors.dart';

/// V4 Minimal Soft - Typography
class V4Fonts {
  static const String fontFamily = 'Nunito';
  static const String fontFamilyAlt = 'Roboto';
  
  // Display Styles - Light, airy
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: V4Colors.textPrimary,
    letterSpacing: -0.5,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: V4Colors.textPrimary,
    letterSpacing: -0.3,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: V4Colors.textPrimary,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: V4Colors.textPrimary,
  );
  
  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: V4Colors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: V4Colors.textPrimary,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: V4Colors.textPrimary,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: V4Colors.textSecondary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: V4Colors.textMuted,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: V4Colors.textPrimary,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: V4Colors.textSecondary,
  );
  
  // Card Styles
  static const TextStyle cardName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static const TextStyle cardAge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  
  static const TextStyle cardBio = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.4,
  );
}

