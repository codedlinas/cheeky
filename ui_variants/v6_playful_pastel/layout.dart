import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V6 Playful Pastel - Layout Configurations
class V6Layout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  
  // Extra rounded
  static const double radiusS = 12;
  static const double radiusM = 20;
  static const double radiusL = 28;
  static const double radiusXL = 40;
  static const double radiusCircle = 100;
  
  static double cardHeight(BuildContext context) => 
      MediaQuery.of(context).size.height * 0.58;
  
  static const double actionButtonSmall = 52;
  static const double actionButtonMedium = 60;
  static const double actionButtonLarge = 70;
  
  static const double bottomNavHeight = 70;
  
  static const double avatarSmall = 44;
  static const double avatarMedium = 60;
  static const double avatarLarge = 88;
}

/// V6 Playful Scaffold
class V6Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const V6Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: V6Colors.background,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// V6 Pastel Container
class V6Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final Gradient? gradient;

  const V6Container({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? V6Layout.cardPadding,
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? V6Colors.surface) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(V6Layout.radiusL),
        boxShadow: V6Colors.softShadow,
      ),
      child: child,
    );
  }
}

/// V6 Section Header with emoji
class V6SectionHeader extends StatelessWidget {
  final String title;
  final String? emoji;
  final Widget? trailing;

  const V6SectionHeader({
    super.key,
    required this.title,
    this.emoji,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V6Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
              ],
              Text(title, style: V6Fonts.headlineMedium),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

