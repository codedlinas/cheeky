import 'package:flutter/material.dart';
import 'dart:ui';
import '../colors.dart';

/// V2 Modern Glassblur - Icon Components
/// Uses rounded Material Icons with glow effects

class V2Icons {
  // Navigation Icons
  static const IconData home = Icons.local_fire_department_rounded;
  static const IconData homeOutline = Icons.local_fire_department_outlined;
  static const IconData matches = Icons.chat_bubble_rounded;
  static const IconData matchesOutline = Icons.chat_bubble_outline_rounded;
  static const IconData profile = Icons.person_rounded;
  static const IconData profileOutline = Icons.person_outline_rounded;
  static const IconData settings = Icons.settings_rounded;
  static const IconData settingsOutline = Icons.settings_outlined;
  
  // Action Icons
  static const IconData like = Icons.favorite_rounded;
  static const IconData likeOutline = Icons.favorite_border_rounded;
  static const IconData pass = Icons.close_rounded;
  static const IconData superLike = Icons.star_rounded;
  static const IconData superLikeOutline = Icons.star_border_rounded;
  static const IconData rewind = Icons.replay_rounded;
  static const IconData boost = Icons.bolt_rounded;
  
  // General Icons
  static const IconData location = Icons.location_on_rounded;
  static const IconData locationOutline = Icons.location_on_outlined;
  static const IconData verified = Icons.verified_rounded;
  static const IconData camera = Icons.camera_alt_rounded;
  static const IconData gallery = Icons.photo_library_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData infoOutline = Icons.info_outline_rounded;
  static const IconData back = Icons.arrow_back_ios_rounded;
  static const IconData forward = Icons.arrow_forward_ios_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData more = Icons.more_horiz_rounded;
  static const IconData filter = Icons.tune_rounded;
  static const IconData send = Icons.send_rounded;
}

/// Glass icon button with blur
class V2IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final bool hasGlass;

  const V2IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
    this.hasGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(size),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: color ?? V2Colors.textPrimary,
            size: size,
          ),
        ),
      ),
    );

    if (!hasGlass) return button;

    return ClipRRect(
      borderRadius: BorderRadius.circular(size + 8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: GlassDecoration(borderRadius: size + 8, hasBorder: false),
          child: button,
        ),
      ),
    );
  }
}

/// Glowing circular icon
class V2CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const V2CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = V2Colors.primary,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: V2Colors.glassGradient,
              border: Border.all(color: V2Colors.glassBorder),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: size * 0.5),
          ),
        ),
      ),
    );
  }
}

/// Badge with glow effect
class V2IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;

  const V2IconBadge({
    super.key,
    required this.icon,
    required this.count,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = badgeColor ?? V2Colors.primary;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: V2Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
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

