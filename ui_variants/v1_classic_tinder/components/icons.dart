import 'package:flutter/material.dart';
import '../colors.dart';

/// V1 Classic Tinder - Icon Components
/// Uses Material Icons with custom styling

class V1Icons {
  // Navigation Icons
  static const IconData home = Icons.local_fire_department;
  static const IconData homeOutline = Icons.local_fire_department_outlined;
  static const IconData matches = Icons.chat_bubble;
  static const IconData matchesOutline = Icons.chat_bubble_outline;
  static const IconData profile = Icons.person;
  static const IconData profileOutline = Icons.person_outline;
  static const IconData settings = Icons.settings;
  static const IconData settingsOutline = Icons.settings_outlined;
  
  // Action Icons
  static const IconData like = Icons.favorite;
  static const IconData likeOutline = Icons.favorite_border;
  static const IconData pass = Icons.close;
  static const IconData superLike = Icons.star;
  static const IconData superLikeOutline = Icons.star_border;
  static const IconData rewind = Icons.replay;
  static const IconData boost = Icons.bolt;
  
  // General Icons
  static const IconData location = Icons.location_on;
  static const IconData locationOutline = Icons.location_on_outlined;
  static const IconData verified = Icons.verified;
  static const IconData camera = Icons.camera_alt;
  static const IconData gallery = Icons.photo_library;
  static const IconData edit = Icons.edit;
  static const IconData info = Icons.info;
  static const IconData infoOutline = Icons.info_outline;
  static const IconData back = Icons.arrow_back_ios;
  static const IconData forward = Icons.arrow_forward_ios;
  static const IconData close = Icons.close;
  static const IconData check = Icons.check;
  static const IconData more = Icons.more_horiz;
  static const IconData filter = Icons.tune;
  static const IconData send = Icons.send;
}

/// Icon button with V1 styling
class V1IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final Color? backgroundColor;

  const V1IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(size),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: color ?? V1Colors.textPrimary,
            size: size,
          ),
        ),
      ),
    );
  }
}

/// Circular icon container
class V1CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final VoidCallback? onTap;

  const V1CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = V1Colors.primary,
    this.backgroundColor = V1Colors.surface,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

/// Badge with icon
class V1IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;

  const V1IconBadge({
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
        Icon(icon, color: V1Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: BoxDecoration(
                color: badgeColor ?? V1Colors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

