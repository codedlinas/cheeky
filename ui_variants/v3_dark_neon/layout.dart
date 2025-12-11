import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

/// V3 Dark Neon - Layout Configurations
class V3Layout {
  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  
  // Spacing
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  
  // Border Radius - Angular for cyberpunk feel
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
  static const double bottomNavHeight = 64;
  
  // Avatar Sizes
  static const double avatarSmall = 40;
  static const double avatarMedium = 56;
  static const double avatarLarge = 80;
}

/// V3 Neon Scaffold
class V3Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool showScanLines;

  const V3Scaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.showScanLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: V3Colors.background,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Stack(
        children: [
          body,
          if (showScanLines) const _ScanLinesOverlay(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// CRT scan lines effect
class _ScanLinesOverlay extends StatelessWidget {
  const _ScanLinesOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: CustomPaint(
          painter: _ScanLinesPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _ScanLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1;
    
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// V3 Neon Container
class V3NeonContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color glowColor;
  final double borderRadius;

  const V3NeonContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.glowColor = V3Colors.primary,
    this.borderRadius = V3Layout.radiusL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? V3Layout.cardPadding,
      decoration: NeonBorderDecoration(
        color: glowColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// V3 Section Header with neon accent
class V3SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const V3SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V3Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: V3Colors.primary,
                      boxShadow: V3Colors.primaryGlow,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(title, style: V3Fonts.headlineMedium),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(subtitle!, style: V3Fonts.bodyMedium),
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

/// Animated neon line
class V3NeonLine extends StatefulWidget {
  final double width;
  final Color color;

  const V3NeonLine({
    super.key,
    this.width = double.infinity,
    this.color = V3Colors.primary,
  });

  @override
  State<V3NeonLine> createState() => _V3NeonLineState();
}

class _V3NeonLineState extends State<V3NeonLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
          width: widget.width,
          height: 2,
          decoration: BoxDecoration(
            color: widget.color,
            boxShadow: V3Colors.neonGlow(widget.color, intensity: 0.5 + _controller.value * 0.5),
          ),
        );
      },
    );
  }
}

