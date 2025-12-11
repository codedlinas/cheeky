import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V4 Minimal Soft - Layout Configurations
class V4Layout {
  // Screen Padding - generous whitespace
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  
  // Spacing - airy
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
  
  // Border Radius - soft
  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  static const double radiusXL = 24;
  static const double radiusCircle = 100;
  
  // Card Dimensions
  static double cardHeight(BuildContext context) => 
      MediaQuery.of(context).size.height * 0.58;
  
  // Action Button Sizes
  static const double actionButtonSmall = 44;
  static const double actionButtonMedium = 52;
  static const double actionButtonLarge = 60;
  
  // Navigation Bar Height
  static const double bottomNavHeight = 56;
  
  // Avatar Sizes
  static const double avatarSmall = 36;
  static const double avatarMedium = 48;
  static const double avatarLarge = 72;
}

/// V4 Clean Scaffold
class V4Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const V4Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: V4Colors.background,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// V4 Clean Container
class V4Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool hasBorder;
  final Color? backgroundColor;

  const V4Container({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.hasBorder = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? V4Layout.cardPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? V4Colors.surface,
        borderRadius: BorderRadius.circular(V4Layout.radiusL),
        border: hasBorder
            ? Border.all(color: V4Colors.border, width: 1)
            : null,
      ),
      child: child,
    );
  }
}

/// V4 Section Header - minimal
class V4SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const V4SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V4Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: V4Fonts.headlineMedium),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: V4Fonts.bodySmall),
              ],
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Simple divider
class V4Divider extends StatelessWidget {
  final double? indent;
  final double? endIndent;

  const V4Divider({
    super.key,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: V4Colors.border,
      thickness: 1,
      height: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

