import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V10PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  const V10PrimaryButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 52, child: Container(decoration: BoxDecoration(color: V10Colors.primary, borderRadius: BorderRadius.circular(V10Layout.radiusM), boxShadow: V10Colors.glowShadow), child: ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V10Layout.radiusM))), child: isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Text(text, style: V10Fonts.labelLarge.copyWith(color: Colors.white)))));
}

class V10SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  const V10SecondaryButton({super.key, required this.text, this.onPressed, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 52, child: OutlinedButton(onPressed: onPressed, style: OutlinedButton.styleFrom(foregroundColor: V10Colors.textPrimary, side: BorderSide(color: V10Colors.primary.withOpacity(0.5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V10Layout.radiusM))), child: Text(text, style: V10Fonts.labelLarge)));
}

class V10ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;
  const V10ActionButton({super.key, required this.icon, required this.color, this.onPressed, this.size = V10Layout.actionButtonMedium});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onPressed, child: Container(width: size, height: size, decoration: BoxDecoration(color: V10Colors.surface, shape: BoxShape.circle, border: Border.all(color: color.withOpacity(0.5)), boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, spreadRadius: 2)]), child: Icon(icon, color: color, size: size * 0.45)));
}

class V10SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;
  const V10SwipeActions({super.key, this.onPass, this.onSuperLike, this.onLike});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [V10ActionButton(icon: Icons.close_rounded, color: V10Colors.passColor, onPressed: onPass, size: V10Layout.actionButtonLarge), const SizedBox(width: 20), V10ActionButton(icon: Icons.star_rounded, color: V10Colors.superLikeColor, onPressed: onSuperLike), const SizedBox(width: 20), V10ActionButton(icon: Icons.favorite_rounded, color: V10Colors.likeColor, onPressed: onLike, size: V10Layout.actionButtonLarge)]);
}

