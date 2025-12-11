import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V4 Minimal Soft - Button Components

class V4PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V4PrimaryButton({
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
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: V4Colors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V4Layout.radiusM),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: V4Fonts.labelLarge.copyWith(color: Colors.white)),
      ),
    );
  }
}

class V4SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V4SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: V4Colors.textPrimary,
          side: const BorderSide(color: V4Colors.border, width: 1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V4Layout.radiusM),
          ),
        ),
        child: Text(text, style: V4Fonts.labelLarge),
      ),
    );
  }
}

class V4TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const V4TextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: V4Colors.primary,
      ),
      child: Text(text, style: V4Fonts.labelLarge.copyWith(color: V4Colors.primary)),
    );
  }
}

/// Minimal action buttons
class V4ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V4ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V4Layout.actionButtonMedium,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: V4Colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: V4Colors.border, width: 1),
        ),
        child: Icon(icon, color: color, size: size * 0.45),
      ),
    );
  }
}

/// Swipe actions row
class V4SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V4SwipeActions({
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
        V4ActionButton(
          icon: Icons.close,
          color: V4Colors.passColor,
          onPressed: onPass,
          size: V4Layout.actionButtonLarge,
        ),
        const SizedBox(width: 24),
        V4ActionButton(
          icon: Icons.star,
          color: V4Colors.superLikeColor,
          onPressed: onSuperLike,
          size: V4Layout.actionButtonMedium,
        ),
        const SizedBox(width: 24),
        V4ActionButton(
          icon: Icons.favorite,
          color: V4Colors.likeColor,
          onPressed: onLike,
          size: V4Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

