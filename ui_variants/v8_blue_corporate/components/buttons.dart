import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V8PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  const V8PrimaryButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 44, child: ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(backgroundColor: V8Colors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V8Layout.radiusS))), child: isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Text(text, style: V8Fonts.labelLarge.copyWith(color: Colors.white))));
}

class V8SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  const V8SecondaryButton({super.key, required this.text, this.onPressed, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 44, child: OutlinedButton(onPressed: onPressed, style: OutlinedButton.styleFrom(foregroundColor: V8Colors.primary, side: const BorderSide(color: V8Colors.primary), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V8Layout.radiusS))), child: Text(text, style: V8Fonts.labelLarge.copyWith(color: V8Colors.primary))));
}

class V8ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;
  const V8ActionButton({super.key, required this.icon, required this.color, this.onPressed, this.size = V8Layout.actionButtonMedium});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onPressed, child: Container(width: size, height: size, decoration: BoxDecoration(color: V8Colors.surface, borderRadius: BorderRadius.circular(V8Layout.radiusS), border: Border.all(color: V8Colors.border), boxShadow: V8Colors.elevation2), child: Icon(icon, color: color, size: size * 0.5)));
}

class V8SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;
  const V8SwipeActions({super.key, this.onPass, this.onSuperLike, this.onLike});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [V8ActionButton(icon: Icons.close, color: V8Colors.passColor, onPressed: onPass, size: V8Layout.actionButtonLarge), const SizedBox(width: 20), V8ActionButton(icon: Icons.star, color: V8Colors.superLikeColor, onPressed: onSuperLike), const SizedBox(width: 20), V8ActionButton(icon: Icons.favorite, color: V8Colors.likeColor, onPressed: onLike, size: V8Layout.actionButtonLarge)]);
}

