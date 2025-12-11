import 'package:flutter/material.dart';
import 'colors.dart';

/// V7 High Contrast Red - Typography
class V7Fonts {
  static const String fontFamily = 'Montserrat';
  
  static const TextStyle displayLarge = TextStyle(fontFamily: fontFamily, fontSize: 36, fontWeight: FontWeight.w900, color: V7Colors.textPrimary, letterSpacing: -1);
  static const TextStyle displayMedium = TextStyle(fontFamily: fontFamily, fontSize: 28, fontWeight: FontWeight.w800, color: V7Colors.textPrimary);
  static const TextStyle headlineLarge = TextStyle(fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w800, color: V7Colors.textPrimary);
  static const TextStyle headlineMedium = TextStyle(fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: V7Colors.textPrimary);
  static const TextStyle titleLarge = TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: V7Colors.textPrimary);
  static const TextStyle titleMedium = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: V7Colors.textPrimary);
  static const TextStyle bodyLarge = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: V7Colors.textPrimary, height: 1.5);
  static const TextStyle bodyMedium = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: V7Colors.textSecondary);
  static const TextStyle labelLarge = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w700, color: V7Colors.textPrimary, letterSpacing: 1);
  static const TextStyle labelMedium = TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w600, color: V7Colors.textSecondary);
  static const TextStyle cardName = TextStyle(fontFamily: fontFamily, fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white);
  static const TextStyle cardAge = TextStyle(fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white);
  static const TextStyle cardBio = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white70);
}

