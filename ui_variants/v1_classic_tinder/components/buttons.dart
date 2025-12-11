import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V1 Classic Tinder - Button Components

class V1PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V1PrimaryButton({
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
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: V1Colors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V1Layout.radiusXL),
          ),
          elevation: 2,
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
            : Text(text, style: V1Fonts.labelLarge.copyWith(color: Colors.white)),
      ),
    );
  }
}

class V1SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V1SecondaryButton({
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
          foregroundColor: V1Colors.primary,
          side: const BorderSide(color: V1Colors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(V1Layout.radiusXL),
          ),
        ),
        child: Text(text, style: V1Fonts.labelLarge.copyWith(color: V1Colors.primary)),
      ),
    );
  }
}

class V1TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const V1TextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: V1Fonts.labelLarge.copyWith(color: V1Colors.primary)),
    );
  }
}

/// Action buttons for swipe cards
class V1ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V1ActionButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
    this.size = V1Layout.actionButtonMedium,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}

/// Swipe action buttons row
class V1SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V1SwipeActions({
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
        V1ActionButton(
          icon: Icons.close,
          color: V1Colors.passColor,
          onPressed: onPass,
          size: V1Layout.actionButtonLarge,
        ),
        const SizedBox(width: 24),
        V1ActionButton(
          icon: Icons.star,
          color: V1Colors.superLikeColor,
          onPressed: onSuperLike,
          size: V1Layout.actionButtonMedium,
        ),
        const SizedBox(width: 24),
        V1ActionButton(
          icon: Icons.favorite,
          color: V1Colors.likeColor,
          onPressed: onLike,
          size: V1Layout.actionButtonLarge,
        ),
      ],
    );
  }
}

