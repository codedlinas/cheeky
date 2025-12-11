import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

/// V4 Minimal Soft - Avatar Components

class V4Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasBorder;

  const V4Avatar({
    super.key,
    this.imageUrl,
    this.size = V4Layout.avatarMedium,
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
                ? Border.all(color: V4Colors.border, width: 1)
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
                color: V4Colors.success,
                shape: BoxShape.circle,
                border: Border.all(color: V4Colors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: V4Colors.surfaceAlt,
      child: Icon(
        Icons.person_outline,
        size: size * 0.5,
        color: V4Colors.textMuted,
      ),
    );
  }
}

/// Simple bordered avatar
class V4BorderedAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final Color borderColor;
  final double borderWidth;

  const V4BorderedAvatar({
    super.key,
    this.imageUrl,
    this.size = V4Layout.avatarLarge,
    this.borderColor = V4Colors.primary,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: V4Avatar(imageUrl: imageUrl, size: size - (borderWidth * 4)),
    );
  }
}

/// Avatar group
class V4AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V4AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V4Layout.avatarSmall,
    this.maxDisplay = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;

    return SizedBox(
      width: size + (displayCount - 1) * (size * 0.65) + (remaining > 0 ? size * 0.65 : 0),
      height: size,
      child: Stack(
        children: [
          ...List.generate(displayCount, (index) {
            return Positioned(
              left: index * (size * 0.65),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: V4Colors.surface, width: 2),
                ),
                child: V4Avatar(
                  imageUrl: imageUrls[index],
                  size: size,
                ),
              ),
            );
          }),
          if (remaining > 0)
            Positioned(
              left: displayCount * (size * 0.65),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: V4Colors.surfaceAlt,
                  shape: BoxShape.circle,
                  border: Border.all(color: V4Colors.surface, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: V4Colors.textSecondary,
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.w500,
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

