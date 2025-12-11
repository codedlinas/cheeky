import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V1 Classic Tinder - Layout Configurations
class V1Layout {
  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  
  // Border Radius
  static const double radiusS = 8;
  static const double radiusM = 16;
  static const double radiusL = 20;
  static const double radiusXL = 30;
  static const double radiusCircle = 100;
  
  // Card Dimensions
  static const double cardAspectRatio = 0.65; // Width / Height
  static double cardHeight(BuildContext context) => 
      MediaQuery.of(context).size.height * 0.6;
  
  // Action Button Sizes
  static const double actionButtonSmall = 48;
  static const double actionButtonMedium = 56;
  static const double actionButtonLarge = 64;
  
  // Navigation Bar Height
  static const double bottomNavHeight = 64;
  
  // Profile Image Sizes
  static const double avatarSmall = 40;
  static const double avatarMedium = 56;
  static const double avatarLarge = 80;
}

/// V1 Screen Scaffold
class V1Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  const V1Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? V1Colors.background,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}

/// V1 Content Container
class V1Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;

  const V1Container({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? V1Layout.screenPadding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}

/// V1 Section Header
class V1SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const V1SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V1Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: V1Fonts.headlineMedium),
              if (subtitle != null)
                Text(subtitle!, style: V1Fonts.bodyMedium),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

