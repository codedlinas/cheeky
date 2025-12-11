import 'package:flutter/material.dart';
import '../colors.dart';

/// V4 Minimal Soft - Icon Components
/// Clean, outlined icons

class V4Icons {
  // Navigation Icons - outlined style
  static const IconData home = Icons.local_fire_department_outlined;
  static const IconData homeActive = Icons.local_fire_department;
  static const IconData matches = Icons.chat_bubble_outline;
  static const IconData matchesActive = Icons.chat_bubble;
  static const IconData profile = Icons.person_outline;
  static const IconData profileActive = Icons.person;
  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsActive = Icons.settings;
  
  // Action Icons
  static const IconData like = Icons.favorite_outline;
  static const IconData likeActive = Icons.favorite;
  static const IconData pass = Icons.close;
  static const IconData superLike = Icons.star_outline;
  static const IconData superLikeActive = Icons.star;
  static const IconData rewind = Icons.replay;
  static const IconData boost = Icons.bolt_outlined;
  
  // General Icons
  static const IconData location = Icons.location_on_outlined;
  static const IconData verified = Icons.verified_outlined;
  static const IconData camera = Icons.camera_alt_outlined;
  static const IconData gallery = Icons.photo_library_outlined;
  static const IconData edit = Icons.edit_outlined;
  static const IconData info = Icons.info_outline;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData close = Icons.close;
  static const IconData check = Icons.check;
  static const IconData more = Icons.more_horiz;
  static const IconData filter = Icons.tune;
  static const IconData send = Icons.send_outlined;
}

/// Simple icon button
class V4IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

  const V4IconButton({
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
      icon: Icon(
        icon,
        color: color ?? V4Colors.textPrimary,
        size: size,
      ),
      splashRadius: size,
    );
  }
}

/// Circular icon with border
class V4CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const V4CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = V4Colors.primary,
    this.size = 44,
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
          color: V4Colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: V4Colors.border, width: 1),
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

/// Simple badge
class V4IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;

  const V4IconBadge({
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
        Icon(icon, color: V4Colors.textPrimary, size: 24),
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              decoration: BoxDecoration(
                color: badgeColor ?? V4Colors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

