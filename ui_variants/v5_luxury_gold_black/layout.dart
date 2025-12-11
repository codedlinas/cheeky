import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V5 Luxury Gold Black - Layout Configurations
class V5Layout {
  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(24);
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
  
  // Border Radius - elegant, not too rounded
  static const double radiusS = 4;
  static const double radiusM = 8;
  static const double radiusL = 16;
  static const double radiusXL = 24;
  
  // Card Dimensions
  static double cardHeight(BuildContext context) => 
      MediaQuery.of(context).size.height * 0.62;
  
  // Action Button Sizes
  static const double actionButtonSmall = 48;
  static const double actionButtonMedium = 56;
  static const double actionButtonLarge = 64;
  
  // Navigation Bar Height
  static const double bottomNavHeight = 60;
  
  // Avatar Sizes
  static const double avatarSmall = 40;
  static const double avatarMedium = 56;
  static const double avatarLarge = 80;
}

/// V5 Luxury Scaffold
class V5Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const V5Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: V5Colors.background,
      extendBody: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(gradient: V5Colors.darkGradient),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// V5 Gold Bordered Container
class V5Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool hasGoldBorder;

  const V5Container({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.hasGoldBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? V5Layout.cardPadding,
      decoration: hasGoldBorder
          ? GoldBorderDecoration()
          : BoxDecoration(
              color: V5Colors.surface,
              borderRadius: BorderRadius.circular(V5Layout.radiusL),
            ),
      child: child,
    );
  }
}

/// V5 Section Header with gold accent
class V5SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const V5SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V5Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                      color: V5Colors.gold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(title, style: V5Fonts.headlineMedium),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(subtitle!, style: V5Fonts.bodySmall),
                ),
              ],
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Gold divider
class V5Divider extends StatelessWidget {
  final double? width;

  const V5Divider({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            V5Colors.gold.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

