import 'package:flutter/material.dart';

class V8Colors {
  static const Color primary = Color(0xFF0078D4);
  static const Color primaryLight = Color(0xFF1890F1);
  static const Color primaryDark = Color(0xFF106EBE);
  
  static const Color secondary = Color(0xFF106EBE);
  static const Color accent = Color(0xFF0063B1);
  
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF3F2F1);
  static const Color surfaceAlt = Color(0xFFEDEBE9);
  
  static const Color textPrimary = Color(0xFF323130);
  static const Color textSecondary = Color(0xFF605E5C);
  static const Color textMuted = Color(0xFFA19F9D);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  static const Color success = Color(0xFF107C10);
  static const Color error = Color(0xFFA80000);
  static const Color warning = Color(0xFFFF8C00);
  static const Color info = Color(0xFF0078D4);
  
  static const Color likeColor = Color(0xFF107C10);
  static const Color passColor = Color(0xFFA80000);
  static const Color superLikeColor = Color(0xFF0078D4);
  
  static const Color border = Color(0xFFE1DFDD);
  
  static List<BoxShadow> get elevation2 => [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 4, offset: const Offset(0, 2))];
  static List<BoxShadow> get elevation4 => [BoxShadow(color: Colors.black.withOpacity(0.14), blurRadius: 8, offset: const Offset(0, 4))];
}

