import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

/// V1 Classic Tinder - Avatar Components

class V1Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasBorder;

  const V1Avatar({
    super.key,
    this.imageUrl,
    this.size = V1Layout.avatarMedium,
    this.showOnline = false,
    this.hasBorder = false,
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
            border: hasBorder
                ? Border.all(color: V1Colors.primary, width: 2)
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
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: V1Colors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: V1Colors.surface,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: V1Colors.textMuted,
      ),
    );
  }
}

/// Gradient bordered avatar for special states
class V1GradientAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double borderWidth;

  const V1GradientAvatar({
    super.key,
    this.imageUrl,
    this.size = V1Layout.avatarLarge,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: V1Colors.primaryGradient,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: V1Colors.background,
        ),
        child: V1Avatar(imageUrl: imageUrl, size: size - (borderWidth * 2) - 4),
      ),
    );
  }
}

/// Avatar group for showing multiple matches
class V1AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V1AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V1Layout.avatarSmall,
    this.maxDisplay = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;

    return SizedBox(
      width: size + (displayCount - 1) * (size * 0.6),
      height: size,
      child: Stack(
        children: [
          ...List.generate(displayCount, (index) {
            return Positioned(
              left: index * (size * 0.6),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: V1Colors.background, width: 2),
                ),
                child: V1Avatar(
                  imageUrl: imageUrls[index],
                  size: size,
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
                  color: V1Colors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: V1Colors.background, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: Colors.white,
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

