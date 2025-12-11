import 'package:flutter/material.dart';

class V10Colors {
  static const Color primary = Color(0xFF7B68EE);
  static const Color primaryLight = Color(0xFF9B8AFB);
  static const Color primaryDark = Color(0xFF5B4BCB);
  
  static const Color secondary = Color(0xFF9B8AFB);
  static const Color accent = Color(0xFFF472B6);
  
  static const Color background = Color(0xFF0F0F1A);
  static const Color backgroundAlt = Color(0xFF080810);
  static const Color surface = Color(0xFF1E1E2E);
  static const Color surfaceLight = Color(0xFF2A2A3E);
  
  static const Color textPrimary = Color(0xFFE4E4E7);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textMuted = Color(0xFF71717A);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF4ADE80);
  static const Color error = Color(0xFFF87171);
  static const Color warning = Color(0xFFFBBF24);
  static const Color info = Color(0xFF60A5FA);
  
  static const Color likeColor = Color(0xFF4ADE80);
  static const Color passColor = Color(0xFFF87171);
  static const Color superLikeColor = Color(0xFF7B68EE);
  
  static List<BoxShadow> get depth3d => [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 15)), BoxShadow(color: primary.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 10))];
  static List<BoxShadow> get glowShadow => [BoxShadow(color: primary.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)];
}

