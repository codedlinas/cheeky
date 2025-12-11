import 'package:flutter/material.dart';
import 'dart:ui';
import 'colors.dart';
import 'fonts.dart';

/// V2 Modern Glassblur - Layout Configurations
class V2Layout {
  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  
  // Border Radius
  static const double radiusS = 12;
  static const double radiusM = 16;
  static const double radiusL = 24;
  static const double radiusXL = 32;
  static const double radiusCircle = 100;
  
  // Card Dimensions
  static double cardHeight(BuildContext context) => 
      MediaQuery.of(context).size.height * 0.65;
  
  // Action Button Sizes
  static const double actionButtonSmall = 52;
  static const double actionButtonMedium = 60;
  static const double actionButtonLarge = 68;
  
  // Navigation Bar Height
  static const double bottomNavHeight = 70;
  
  // Blur Values
  static const double blurLight = 10;
  static const double blurMedium = 20;
  static const double blurHeavy = 30;
  
  // Profile Image Sizes
  static const double avatarSmall = 44;
  static const double avatarMedium = 60;
  static const double avatarLarge = 88;
}

/// V2 Glass Scaffold
class V2Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool hasGradientBackground;

  const V2Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.hasGradientBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: V2Colors.background,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: hasGradientBackground
            ? const BoxDecoration(gradient: V2Colors.backgroundGradient)
            : null,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// V2 Glass Container
class V2GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final double blurAmount;

  const V2GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = V2Layout.radiusL,
    this.blurAmount = V2Layout.blurLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: padding ?? V2Layout.cardPadding,
            decoration: GlassDecoration(borderRadius: borderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// V2 Section Header
class V2SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const V2SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V2Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: V2Fonts.headlineMedium),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: V2Fonts.bodySmall),
              ],
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Animated gradient background
class V2AnimatedBackground extends StatefulWidget {
  final Widget child;

  const V2AnimatedBackground({super.key, required this.child});

  @override
  State<V2AnimatedBackground> createState() => _V2AnimatedBackgroundState();
}

class _V2AnimatedBackgroundState extends State<V2AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                V2Colors.background,
                V2Colors.backgroundDark,
                Color(0xFF1E1E3F),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

