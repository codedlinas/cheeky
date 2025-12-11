import 'package:flutter/material.dart';
import 'dart:ui';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V2 Modern Glassblur - Button Components

class V2PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V2PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          gradient: V2Colors.primaryGradient,
          borderRadius: BorderRadius.circular(V2Layout.radiusM),
          boxShadow: V2Colors.glowShadow,
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(V2Layout.radiusM),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(text, style: V2Fonts.labelLarge.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}

class V2SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V2SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V2Layout.radiusM),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: GlassDecoration(borderRadius: V2Layout.radiusM),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: V2Colors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(V2Layout.radiusM),
                ),
              ),
              child: Text(text, style: V2Fonts.labelLarge),
            ),
          ),
        ),
      ),
    );
  }
}

class V2TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const V2TextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: V2Fonts.labelLarge.copyWith(color: V2Colors.primary)),
    );
  }
}

/// Glass action buttons for swipe cards
class V2ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V2ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V2Layout.actionButtonMedium,
  });

  @override
  State<V2ActionButton> createState() => _V2ActionButtonState();
}

class _V2ActionButtonState extends State<V2ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_controller.value * 0.1),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: V2Colors.glassGradient,
                    border: Border.all(
                      color: widget.color.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: widget.size * 0.45,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Swipe action buttons row with glass effect
class V2SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V2SwipeActions({
    super.key,
    this.onPass,
    this.onSuperLike,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        V2ActionButton(
          icon: Icons.close_rounded,
          color: V2Colors.passColor,
          onPressed: onPass,
          size: V2Layout.actionButtonLarge,
        ),
        const SizedBox(width: 20),
        V2ActionButton(
          icon: Icons.star_rounded,
          color: V2Colors.superLikeColor,
          onPressed: onSuperLike,
          size: V2Layout.actionButtonMedium,
        ),
        const SizedBox(width: 20),
        V2ActionButton(
          icon: Icons.favorite_rounded,
          color: V2Colors.likeColor,
          onPressed: onLike,
          size: V2Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

