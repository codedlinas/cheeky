import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V5 Luxury Gold Black - Button Components

class V5PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V5PrimaryButton({
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
      height: 52,
      child: Container(
        decoration: BoxDecoration(
          gradient: V5Colors.goldGradient,
          borderRadius: BorderRadius.circular(V5Layout.radiusM),
          boxShadow: V5Colors.goldGlow,
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(V5Layout.radiusM),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(V5Colors.background),
                  ),
                )
              : Text(
                  text.toUpperCase(),
                  style: V5Fonts.labelLarge.copyWith(
                    color: V5Colors.background,
                    letterSpacing: 2,
                  ),
                ),
        ),
      ),
    );
  }
}

class V5SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V5SecondaryButton({
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
          foregroundColor: V5Colors.gold,
          side: const BorderSide(color: V5Colors.gold, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V5Layout.radiusM),
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: V5Fonts.labelLarge.copyWith(
            color: V5Colors.gold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class V5TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const V5TextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: V5Fonts.labelLarge.copyWith(
          color: V5Colors.gold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

/// Luxury action buttons
class V5ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;
  final bool isGold;

  const V5ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V5Layout.actionButtonMedium,
    this.isGold = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: V5Colors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: isGold ? V5Colors.gold : color.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: isGold ? V5Colors.goldGlow : V5Colors.luxuryShadow,
        ),
        child: Icon(icon, color: color, size: size * 0.45),
      ),
    );
  }
}

/// Swipe actions row
class V5SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V5SwipeActions({
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
        V5ActionButton(
          icon: Icons.close,
          color: V5Colors.passColor,
          onPressed: onPass,
          size: V5Layout.actionButtonLarge,
        ),
        const SizedBox(width: 24),
        V5ActionButton(
          icon: Icons.star,
          color: V5Colors.gold,
          onPressed: onSuperLike,
          size: V5Layout.actionButtonMedium,
          isGold: true,
        ),
        const SizedBox(width: 24),
        V5ActionButton(
          icon: Icons.favorite,
          color: V5Colors.likeColor,
          onPressed: onLike,
          size: V5Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

