import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';

/// V3 Dark Neon - Icon Components
/// Sharp, angular icons with neon glow effects

class V3Icons {
  // Navigation Icons
  static const IconData home = Icons.whatshot;
  static const IconData homeOutline = Icons.whatshot_outlined;
  static const IconData matches = Icons.message;
  static const IconData matchesOutline = Icons.message_outlined;
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
  static const IconData boost = Icons.flash_on;
  
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

/// Neon glow icon button
class V3IconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final bool hasGlow;

  const V3IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
    this.hasGlow = false,
  });

  @override
  State<V3IconButton> createState() => _V3IconButtonState();
}

class _V3IconButtonState extends State<V3IconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.hasGlow) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? V3Colors.textPrimary;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.size),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(widget.size),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: widget.hasGlow
                  ? BoxDecoration(
                      boxShadow: V3Colors.neonGlow(
                        color,
                        intensity: 0.3 + (_controller.value * 0.4),
                      ),
                    )
                  : null,
              child: Icon(
                widget.icon,
                color: color,
                size: widget.size,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Circular neon icon
class V3CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const V3CircularIcon({
    super.key,
    required this.icon,
    this.iconColor = V3Colors.primary,
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
          color: V3Colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: iconColor, width: 2),
          boxShadow: V3Colors.neonGlow(iconColor, intensity: 0.4),
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}

/// Badge with neon glow
class V3IconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color? badgeColor;

  const V3IconBadge({
    super.key,
    required this.icon,
    required this.count,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = badgeColor ?? V3Colors.primary;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: V3Colors.textPrimary, size: 26),
        if (count > 0)
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: V3Colors.neonGlow(color, intensity: 0.6),
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: V3Fonts.labelMedium.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

