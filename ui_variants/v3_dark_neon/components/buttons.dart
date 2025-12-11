import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V3 Dark Neon - Button Components

class V3PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V3PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  State<V3PrimaryButton> createState() => _V3PrimaryButtonState();
}

class _V3PrimaryButtonState extends State<V3PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: widget.width ?? double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(V3Layout.radiusM),
            border: Border.all(color: V3Colors.primary, width: 2),
            boxShadow: V3Colors.neonGlow(
              V3Colors.primary,
              intensity: 0.3 + (_pulseController.value * 0.3),
            ),
          ),
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: V3Colors.surface,
              foregroundColor: V3Colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(V3Layout.radiusM - 2),
              ),
              elevation: 0,
            ),
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(V3Colors.primary),
                    ),
                  )
                : Text(
                    widget.text.toUpperCase(),
                    style: V3Fonts.neonText(V3Colors.primary, fontSize: 14),
                  ),
          ),
        );
      },
    );
  }
}

class V3SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V3SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: V3Colors.secondary,
          side: const BorderSide(color: V3Colors.secondary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V3Layout.radiusM),
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: V3Fonts.labelLarge.copyWith(color: V3Colors.secondary),
        ),
      ),
    );
  }
}

/// Neon action buttons
class V3ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V3ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V3Layout.actionButtonMedium,
  });

  @override
  State<V3ActionButton> createState() => _V3ActionButtonState();
}

class _V3ActionButtonState extends State<V3ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final pulseIntensity = 0.3 + (_controller.value * 0.4);
          
          return AnimatedScale(
            scale: _isPressed ? 0.9 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: V3Colors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: widget.color, width: 2),
                boxShadow: V3Colors.neonGlow(widget.color, intensity: pulseIntensity),
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: widget.size * 0.45,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Swipe actions row
class V3SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V3SwipeActions({
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
        V3ActionButton(
          icon: Icons.close,
          color: V3Colors.passColor,
          onPressed: onPass,
          size: V3Layout.actionButtonLarge,
        ),
        const SizedBox(width: 20),
        V3ActionButton(
          icon: Icons.star,
          color: V3Colors.superLikeColor,
          onPressed: onSuperLike,
          size: V3Layout.actionButtonMedium,
        ),
        const SizedBox(width: 20),
        V3ActionButton(
          icon: Icons.favorite,
          color: V3Colors.likeColor,
          onPressed: onLike,
          size: V3Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

