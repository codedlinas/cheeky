import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V9PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  const V9PrimaryButton({super.key, required this.text, this.onPressed, this.isLoading = false, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 54, child: Container(decoration: BoxDecoration(color: V9Colors.primary, borderRadius: BorderRadius.circular(V9Layout.radiusXL), boxShadow: V9Colors.bubbleShadow), child: ElevatedButton(onPressed: isLoading ? null : onPressed, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V9Layout.radiusXL))), child: isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Text(text, style: V9Fonts.labelLarge.copyWith(color: Colors.white)))));
}

class V9SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  const V9SecondaryButton({super.key, required this.text, this.onPressed, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width ?? double.infinity, height: 54, child: OutlinedButton(onPressed: onPressed, style: OutlinedButton.styleFrom(foregroundColor: V9Colors.primary, side: const BorderSide(color: V9Colors.primary, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(V9Layout.radiusXL))), child: Text(text, style: V9Fonts.labelLarge.copyWith(color: V9Colors.primary))));
}

class V9ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double size;
  const V9ActionButton({super.key, required this.icon, required this.color, this.onPressed, this.size = V9Layout.actionButtonMedium});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onPressed, child: Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 6))]), child: Icon(icon, color: Colors.white, size: size * 0.45)));
}

class V9SwipeActions extends StatelessWidget {
  final VoidCallback? onPass;
  final VoidCallback? onSuperLike;
  final VoidCallback? onLike;
  const V9SwipeActions({super.key, this.onPass, this.onSuperLike, this.onLike});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [V9ActionButton(icon: Icons.close_rounded, color: V9Colors.passColor, onPressed: onPass, size: V9Layout.actionButtonLarge), const SizedBox(width: 20), V9ActionButton(icon: Icons.star_rounded, color: V9Colors.superLikeColor, onPressed: onSuperLike), const SizedBox(width: 20), V9ActionButton(icon: Icons.favorite_rounded, color: V9Colors.likeColor, onPressed: onLike, size: V9Layout.actionButtonLarge)]);
}

