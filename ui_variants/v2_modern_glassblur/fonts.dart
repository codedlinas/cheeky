import 'package:flutter/material.dart';
import 'colors.dart';

/// V2 Modern Glassblur - Typography
class V2Fonts {
  static const String fontFamily = 'Poppins';
  static const String fontFamilyAlt = 'Sora';
  
  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: V2Colors.textPrimary,
    letterSpacing: -1,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyAlt,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: V2Colors.textPrimary,
    letterSpacing: -0.5,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: V2Colors.textPrimary,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: V2Colors.textPrimary,
  );
  
  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: V2Colors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: V2Colors.textPrimary,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: V2Colors.textPrimary,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: V2Colors.textSecondary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: V2Colors.textMuted,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: V2Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: V2Colors.textSecondary,
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
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  
  static const TextStyle cardBio = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.4,
  );
}

