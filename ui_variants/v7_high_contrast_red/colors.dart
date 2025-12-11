import 'package:flutter/material.dart';

/// V7 High Contrast Red - Color Palette
class V7Colors {
  static const Color primary = Color(0xFFE53935);
  static const Color primaryLight = Color(0xFFFF5252);
  static const Color primaryDark = Color(0xFFD32F2F);
  
  static const Color secondary = Color(0xFF212121);
  static const Color accent = Color(0xFFFF1744);
  
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF212121);
  
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF424242);
  static const Color textMuted = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  static const Color likeColor = Color(0xFF4CAF50);
  static const Color passColor = Color(0xFFE53935);
  static const Color superLikeColor = Color(0xFF2196F3);
  
  static List<BoxShadow> get sharpShadow => [
    const BoxShadow(color: Colors.black26, blurRadius: 0, offset: Offset(4, 4)),
  ];
  
  static List<BoxShadow> get deepShadow => [
    BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
  ];
}

