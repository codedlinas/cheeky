import 'package:flutter/material.dart';
import '../colors.dart';

class V9Icons {
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

class V9IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  const V9IconButton({super.key, required this.icon, this.onPressed, this.color, this.size = 24});
  @override
  Widget build(BuildContext context) => IconButton(onPressed: onPressed, icon: Icon(icon, color: color ?? V9Colors.textPrimary, size: size), splashRadius: size);
}

class V9CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final VoidCallback? onTap;
  const V9CircularIcon({super.key, required this.icon, this.iconColor = Colors.white, this.backgroundColor = V9Colors.primary, this.size = 48, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(width: size, height: size, decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: backgroundColor.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))]), child: Icon(icon, color: iconColor, size: size * 0.5)));
}

class V9IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  const V9IconBadge({super.key, required this.icon, required this.count});
  @override
  Widget build(BuildContext context) => Stack(clipBehavior: Clip.none, children: [Icon(icon, color: V9Colors.textPrimary, size: 26), if (count > 0) Positioned(right: -8, top: -8, child: Container(padding: const EdgeInsets.all(4), constraints: const BoxConstraints(minWidth: 18, minHeight: 18), decoration: BoxDecoration(color: V9Colors.primary, shape: BoxShape.circle), child: Center(child: Text(count > 99 ? '99+' : count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))))]);
}

