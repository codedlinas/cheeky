import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V7PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const V7PrimaryButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: V7Colors.primary, shape: const RoundedRectangleBorder()),
        child: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
            : Text(text.toUpperCase(), style: V7Fonts.labelLarge.copyWith(color: Colors.white)),
      ),
    );
  }
}

class V7SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;

  const V7SecondaryButton({super.key, required this.text, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(foregroundColor: V7Colors.textPrimary, side: const BorderSide(color: V7Colors.textPrimary, width: 2), shape: const RoundedRectangleBorder()),
        child: Text(text.toUpperCase(), style: V7Fonts.labelLarge),
      ),
    );
  }
}

class V7ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;

  const V7ActionButton({super.key, required this.icon, required this.color, this.onPressed, this.size = V7Layout.actionButtonMedium});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, boxShadow: V7Colors.sharpShadow),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}

class V7SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;

  const V7SwipeActions({super.key, this.onPass, this.onSuperLike, this.onLike});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        V7ActionButton(icon: Icons.close, color: V7Colors.passColor, onPressed: onPass, size: V7Layout.actionButtonLarge),
        const SizedBox(width: 20),
        V7ActionButton(icon: Icons.star, color: V7Colors.superLikeColor, onPressed: onSuperLike, size: V7Layout.actionButtonMedium),
        const SizedBox(width: 20),
        V7ActionButton(icon: Icons.favorite, color: V7Colors.likeColor, onPressed: onLike, size: V7Layout.actionButtonLarge),
      ],
    );
  }
}

