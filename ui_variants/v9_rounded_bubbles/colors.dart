import 'package:flutter/material.dart';

class V9Colors {
  static const Color primary = Color(0xFFFF6B9D);
  static const Color primaryLight = Color(0xFFFF8FB3);
  static const Color primaryDark = Color(0xFFC44569);
  
  static const Color secondary = Color(0xFFC44569);
  static const Color accent = Color(0xFFFD79A8);
  
  static const Color background = Color(0xFFFEF9F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFFFF5EE);
  
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textMuted = Color(0xFFB2BEC3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF55EFC4);
  static const Color error = Color(0xFFFF7675);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF74B9FF);
  
  static const Color likeColor = Color(0xFF55EFC4);
  static const Color passColor = Color(0xFFFF7675);
  static const Color superLikeColor = Color(0xFFFF6B9D);
  
  static List<BoxShadow> get bubbleShadow => [BoxShadow(color: primary.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))];
  static List<BoxShadow> get softShadow => [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 5))];
}

