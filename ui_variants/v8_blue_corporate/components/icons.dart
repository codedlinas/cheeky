import 'package:flutter/material.dart';
import '../colors.dart';

class V8Icons {
  static const IconData home = Icons.local_fire_department_outlined;
  static const IconData homeActive = Icons.local_fire_department;
  static const IconData matches = Icons.chat_bubble_outline;
  static const IconData matchesActive = Icons.chat_bubble;
  static const IconData profile = Icons.person_outline;
  static const IconData profileActive = Icons.person;
  static const IconData like = Icons.favorite_outline;
  static const IconData likeActive = Icons.favorite;
  static const IconData pass = Icons.close;
  static const IconData superLike = Icons.star_outline;
  static const IconData location = Icons.location_on_outlined;
  static const IconData camera = Icons.camera_alt_outlined;
  static const IconData edit = Icons.edit_outlined;
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close;
  static const IconData send = Icons.send_outlined;
}

class V8IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  const V8IconButton({super.key, required this.icon, this.onPressed, this.color, this.size = 24});
  @override
  Widget build(BuildContext context) => IconButton(onPressed: onPressed, icon: Icon(icon, color: color ?? V8Colors.textPrimary, size: size));
}

class V8CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  const V8CircularIcon({super.key, required this.icon, this.iconColor = V8Colors.primary, this.size = 44, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(width: size, height: size, decoration: BoxDecoration(color: V8Colors.surface, borderRadius: BorderRadius.circular(V8Layout.radiusS), border: Border.all(color: V8Colors.border)), child: Icon(icon, color: iconColor, size: size * 0.5)));
}

class V8IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  const V8IconBadge({super.key, required this.icon, required this.count});
  @override
  Widget build(BuildContext context) => Stack(clipBehavior: Clip.none, children: [Icon(icon, color: V8Colors.textPrimary, size: 24), if (count > 0) Positioned(right: -6, top: -6, child: Container(padding: const EdgeInsets.all(4), constraints: const BoxConstraints(minWidth: 16, minHeight: 16), decoration: BoxDecoration(color: V8Colors.primary, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(count > 99 ? '99+' : count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)))))]);
}

