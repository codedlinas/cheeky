import 'package:flutter/material.dart';
import 'colors.dart';

/// V5 Luxury Gold Black - Typography
class V5Fonts {
  static const String fontFamilySerif = 'Playfair Display';
  static const String fontFamilySans = 'Inter';
  
  // Display Styles - Elegant serif
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: V5Colors.textPrimary,
    letterSpacing: 1,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: V5Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: V5Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: V5Colors.textPrimary,
  );
  
  // Title Styles - Mix of serif and sans
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: V5Colors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: V5Colors.textPrimary,
  );
  
  // Body Styles - Clean sans-serif
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: V5Colors.textPrimary,
    height: 1.6,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: V5Colors.textSecondary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: V5Colors.textMuted,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: V5Colors.textPrimary,
    letterSpacing: 1,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: V5Colors.textSecondary,
    letterSpacing: 0.5,
  );
  
  // Card Styles - Luxurious
  static const TextStyle cardName = TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1,
  );
  
  static const TextStyle cardAge = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 24,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
  
  static const TextStyle cardBio = TextStyle(
    fontFamily: fontFamilySans,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.5,
  );
  
  // Gold accent text
  static TextStyle goldText({double fontSize = 16}) => TextStyle(
    fontFamily: fontFamilySerif,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: V5Colors.gold,
    letterSpacing: 1,
  );
}

