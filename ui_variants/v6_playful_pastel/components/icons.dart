import 'package:flutter/material.dart';
import '../colors.dart';

/// V6 Playful Pastel - Icon Components
class V6Icons {
  static const IconData home = Icons.local_fire_department_rounded;
  static const IconData homeOutline = Icons.local_fire_department_outlined;
  static const IconData matches = Icons.chat_bubble_rounded;
  static const IconData matchesOutline = Icons.chat_bubble_outline_rounded;
  static const IconData profile = Icons.person_rounded;
  static const IconData profileOutline = Icons.person_outline_rounded;
  static const IconData settings = Icons.settings_rounded;
  static const IconData like = Icons.favorite_rounded;
  static const IconData likeOutline = Icons.favorite_border_rounded;
  static const IconData pass = Icons.close_rounded;
  static const IconData superLike = Icons.star_rounded;
  static const IconData location = Icons.location_on_rounded;
  static const IconData camera = Icons.camera_alt_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData back = Icons.arrow_back_ios_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData send = Icons.send_rounded;
}

/// Colorful icon button
class V6IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

  const V6IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color ?? V6Colors.textPrimary, size: size),
      splashRadius: size,
    );
  }
}

/// Circular icon with pastel background
class V6CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final VoidCallback? onTap;

  const V6CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.backgroundColor = V6Colors.primary,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: V6Colors.colorShadow(backgroundColor),
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

/// Badge
class V6IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;

  const V6IconBadge({
    super.key,
    required this.icon,
    required this.count,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: V6Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: BoxDecoration(
                color: badgeColor ?? V6Colors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

