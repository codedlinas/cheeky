import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V6 Playful Pastel - Button Components

class V6PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final Color? color;

  const V6PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 54,
      child: Container(
        decoration: BoxDecoration(
          gradient: color == null ? V6Colors.sunsetPastel : null,
          color: color,
          borderRadius: BorderRadius.circular(V6Layout.radiusCircle),
          boxShadow: V6Colors.colorShadow(color ?? V6Colors.primary),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(V6Layout.radiusCircle),
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
              : Text(text, style: V6Fonts.labelLarge.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}

class V6SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Color? color;

  const V6SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color ?? V6Colors.primary,
          side: BorderSide(color: color ?? V6Colors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V6Layout.radiusCircle),
          ),
        ),
        child: Text(text, style: V6Fonts.labelLarge.copyWith(color: color ?? V6Colors.primary)),
      ),
    );
  }
}

/// Playful action buttons
class V6ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V6ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V6Layout.actionButtonMedium,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: V6Colors.colorShadow(color),
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}

/// Swipe actions row
class V6SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V6SwipeActions({
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
        V6ActionButton(
          icon: Icons.close_rounded,
          color: V6Colors.coral,
          onPressed: onPass,
          size: V6Layout.actionButtonLarge,
        ),
        const SizedBox(width: 20),
        V6ActionButton(
          icon: Icons.star_rounded,
          color: V6Colors.purple,
          onPressed: onSuperLike,
          size: V6Layout.actionButtonMedium,
        ),
        const SizedBox(width: 20),
        V6ActionButton(
          icon: Icons.favorite_rounded,
          color: V6Colors.accent,
          onPressed: onLike,
          size: V6Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

