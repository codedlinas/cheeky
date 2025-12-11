import 'package:flutter/material.dart';
import '../colors.dart';

class V7Icons {
  static const IconData home = Icons.local_fire_department;
  static const IconData homeOutline = Icons.local_fire_department_outlined;
  static const IconData matches = Icons.chat_bubble;
  static const IconData matchesOutline = Icons.chat_bubble_outline;
  static const IconData profile = Icons.person;
  static const IconData profileOutline = Icons.person_outline;
  static const IconData like = Icons.favorite;
  static const IconData pass = Icons.close;
  static const IconData superLike = Icons.star;
  static const IconData location = Icons.location_on;
  static const IconData camera = Icons.camera_alt;
  static const IconData edit = Icons.edit;
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close;
  static const IconData send = Icons.send;
}

class V7IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

  const V7IconButton({super.key, required this.icon, this.onPressed, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(icon, color: color ?? V7Colors.textPrimary, size: size));
  }
}

class V7CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final VoidCallback? onTap;

  const V7CircularIcon({super.key, required this.icon, this.iconColor = Colors.white, this.backgroundColor = V7Colors.primary, this.size = 48, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: backgroundColor, boxShadow: V7Colors.sharpShadow),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

class V7IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;

  const V7IconBadge({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: V7Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              color: V7Colors.primary,
              child: Center(child: Text(count > 99 ? '99+' : count.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
            ),
          ),
      ],
    );
  }
}

