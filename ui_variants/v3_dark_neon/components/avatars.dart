import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

/// V3 Dark Neon - Avatar Components

class V3Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasNeonBorder;
  final Color borderColor;

  const V3Avatar({
    super.key,
    this.imageUrl,
    this.size = V3Layout.avatarMedium,
    this.showOnline = false,
    this.hasNeonBorder = false,
    this.borderColor = V3Colors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: hasNeonBorder
                ? Border.all(color: borderColor, width: 2)
                : null,
            boxShadow: hasNeonBorder
                ? V3Colors.neonGlow(borderColor, intensity: 0.4)
                : null,
          ),
          child: ClipOval(
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
        ),
        if (showOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: V3Colors.success,
                shape: BoxShape.circle,
                border: Border.all(color: V3Colors.background, width: 2),
                boxShadow: V3Colors.neonGlow(V3Colors.success, intensity: 0.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: V3Colors.surface,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: V3Colors.textMuted,
      ),
    );
  }
}

/// Animated neon border avatar
class V3NeonAvatar extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final List<Color> colors;

  const V3NeonAvatar({
    super.key,
    this.imageUrl,
    this.size = V3Layout.avatarLarge,
    this.colors = const [V3Colors.primary, V3Colors.secondary, V3Colors.accent],
  });

  @override
  State<V3NeonAvatar> createState() => _V3NeonAvatarState();
}

class _V3NeonAvatarState extends State<V3NeonAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final colorIndex = (_controller.value * widget.colors.length).floor() % widget.colors.length;
        final currentColor = widget.colors[colorIndex];
        
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: currentColor, width: 3),
            boxShadow: V3Colors.neonGlow(currentColor),
          ),
          child: V3Avatar(
            imageUrl: widget.imageUrl,
            size: widget.size - 8,
          ),
        );
      },
    );
  }
}

/// Avatar group with neon styling
class V3AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V3AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V3Layout.avatarSmall,
    this.maxDisplay = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;

    return SizedBox(
      width: size + (displayCount - 1) * (size * 0.6) + (remaining > 0 ? size * 0.6 : 0),
      height: size,
      child: Stack(
        children: [
          ...List.generate(displayCount, (index) {
            return Positioned(
              left: index * (size * 0.6),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: V3Colors.background, width: 2),
                ),
                child: V3Avatar(
                  imageUrl: imageUrls[index],
                  size: size,
                  hasNeonBorder: true,
                  borderColor: V3Colors.primary,
                ),
              ),
            );
          }),
          if (remaining > 0)
            Positioned(
              left: displayCount * (size * 0.6),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: V3Colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: V3Colors.primary, width: 2),
                  boxShadow: V3Colors.neonGlow(V3Colors.primary, intensity: 0.3),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: V3Colors.primary,
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

