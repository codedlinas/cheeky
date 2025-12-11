import 'package:flutter/material.dart';

/// V6 Playful Pastel - Color Palette
class V6Colors {
  // Pastel Primary Colors
  static const Color primary = Color(0xFFFF9ECD);
  static const Color primaryLight = Color(0xFFFFB8DC);
  static const Color primaryDark = Color(0xFFE87DB3);
  
  // Fun Accent Colors
  static const Color secondary = Color(0xFFFFB347);
  static const Color accent = Color(0xFFB4F8C8);
  static const Color purple = Color(0xFFC9B1FF);
  static const Color blue = Color(0xFFA0E7E5);
  static const Color yellow = Color(0xFFFFF0A5);
  static const Color coral = Color(0xFFFFADAD);
  
  // Background Colors
  static const Color background = Color(0xFFFFF5F5);
  static const Color backgroundAlt = Color(0xFFFFF9F0);
  static const Color surface = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF4A4A4A);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color textMuted = Color(0xFFAAAAAA);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Status Colors - Pastel versions
  static const Color success = Color(0xFFB4F8C8);
  static const Color error = Color(0xFFFFADAD);
  static const Color warning = Color(0xFFFFF0A5);
  static const Color info = Color(0xFFA0E7E5);
  
  // Swipe Colors
  static const Color likeColor = Color(0xFFB4F8C8);
  static const Color passColor = Color(0xFFFFADAD);
  static const Color superLikeColor = Color(0xFFC9B1FF);
  
  // Fun Gradients
  static const LinearGradient rainbowPastel = LinearGradient(
    colors: [primary, purple, blue, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient sunsetPastel = LinearGradient(
    colors: [Color(0xFFFF9ECD), Color(0xFFFFB347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient mintFresh = LinearGradient(
    colors: [Color(0xFFA0E7E5), Color(0xFFB4F8C8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Soft Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primary.withOpacity(0.2),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> colorShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 6),
    ),
  ];
}

