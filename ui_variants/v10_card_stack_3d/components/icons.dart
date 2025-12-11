import 'package:flutter/material.dart';
import '../colors.dart';

class V10Icons {
  static const IconData home = Icons.local_fire_department_rounded;
  static const IconData homeOutline = Icons.local_fire_department_outlined;
  static const IconData matches = Icons.chat_bubble_rounded;
  static const IconData matchesOutline = Icons.chat_bubble_outline_rounded;
  static const IconData profile = Icons.person_rounded;
  static const IconData profileOutline = Icons.person_outline_rounded;
  static const IconData like = Icons.favorite_rounded;
  static const IconData likeOutline = Icons.favorite_border_rounded;
  static const IconData pass = Icons.close_rounded;
  static const IconData superLike = Icons.star_rounded;
  static const IconData location = Icons.location_on_rounded;
  static const IconData camera = Icons.camera_alt_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData back = Icons.arrow_back_ios_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData send = Icons.send_rounded;
}

class V10IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  const V10IconButton({super.key, required this.icon, this.onPressed, this.color, this.size = 24});
  @override
  Widget build(BuildContext context) => IconButton(onPressed: onPressed, icon: Icon(icon, color: color ?? V10Colors.textPrimary, size: size));
}

class V10CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  const V10CircularIcon({super.key, required this.icon, this.iconColor = V10Colors.primary, this.size = 48, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(width: size, height: size, decoration: BoxDecoration(color: V10Colors.surface, shape: BoxShape.circle, border: Border.all(color: iconColor.withOpacity(0.3)), boxShadow: [BoxShadow(color: iconColor.withOpacity(0.2), blurRadius: 12)]), child: Icon(icon, color: iconColor, size: size * 0.5)));
}

class V10IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  const V10IconBadge({super.key, required this.icon, required this.count});
  @override
  Widget build(BuildContext context) => Stack(clipBehavior: Clip.none, children: [Icon(icon, color: V10Colors.textPrimary, size: 26), if (count > 0) Positioned(right: -8, top: -8, child: Container(padding: const EdgeInsets.all(4), constraints: const BoxConstraints(minWidth: 18, minHeight: 18), decoration: BoxDecoration(gradient: LinearGradient(colors: [V10Colors.primary, V10Colors.accent]), shape: BoxShape.circle, boxShadow: V10Colors.glowShadow), child: Center(child: Text(count > 99 ? '99+' : count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))))]);
}

