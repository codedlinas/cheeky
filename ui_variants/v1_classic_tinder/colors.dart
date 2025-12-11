import 'package:flutter/material.dart';

/// V1 Classic Tinder - Color Palette
class V1Colors {
  // Primary Colors
  static const Color primary = Color(0xFFFF4F70);
  static const Color primaryLight = Color(0xFFFF6B8A);
  static const Color primaryDark = Color(0xFFE83E5F);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFF8C94);
  static const Color accent = Color(0xFFFFD700);
  
  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F8F8);
  static const Color card = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF4CD964);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFFCC00);
  static const Color info = Color(0xFF007AFF);
  
  // Swipe Colors
  static const Color likeColor = Color(0xFF4CD964);
  static const Color passColor = Color(0xFFFF3B30);
  static const Color superLikeColor = Color(0xFF007AFF);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0x80000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];
}

