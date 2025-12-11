import 'package:flutter/material.dart';
import '../colors.dart';

/// V5 Luxury Gold Black - Icon Components
/// Elegant icons with gold accents

class V5Icons {
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
  
  // Luxury specific
  static const IconData crown = Icons.workspace_premium;
  static const IconData diamond = Icons.diamond;
}

/// Gold icon button
class V5IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final bool useGold;

  const V5IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
    this.useGold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(size),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: useGold ? V5Colors.gold : (color ?? V5Colors.textPrimary),
            size: size,
          ),
        ),
      ),
    );
  }
}

/// Gold circular icon
class V5CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  final bool hasGoldBorder;

  const V5CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = V5Colors.gold,
    this.size = 48,
    this.onTap,
    this.hasGoldBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: V5Colors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: hasGoldBorder ? V5Colors.gold : V5Colors.gold.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: hasGoldBorder ? V5Colors.goldGlow : null,
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

/// Gold badge
class V5IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool useGold;

  const V5IconBadge({
    super.key,
    required this.icon,
    required this.count,
    this.useGold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: V5Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: BoxDecoration(
                gradient: useGold ? V5Colors.goldGradient : null,
                color: useGold ? null : V5Colors.gold,
                shape: BoxShape.circle,
                boxShadow: useGold ? V5Colors.goldGlow : null,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: TextStyle(
                    color: V5Colors.background,
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

