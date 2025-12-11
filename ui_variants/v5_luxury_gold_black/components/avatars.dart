import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

/// V5 Luxury Gold Black - Avatar Components

class V5Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasGoldBorder;

  const V5Avatar({
    super.key,
    this.imageUrl,
    this.size = V5Layout.avatarMedium,
    this.showOnline = false,
    this.hasGoldBorder = false,
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
            border: hasGoldBorder
                ? Border.all(color: V5Colors.gold, width: 2)
                : null,
            boxShadow: hasGoldBorder ? V5Colors.goldGlow : null,
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
                color: V5Colors.success,
                shape: BoxShape.circle,
                border: Border.all(color: V5Colors.background, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: V5Colors.surface,
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: V5Colors.textMuted,
      ),
    );
  }
}

/// Gold gradient bordered avatar
class V5GoldAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double borderWidth;

  const V5GoldAvatar({
    super.key,
    this.imageUrl,
    this.size = V5Layout.avatarLarge,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: V5Colors.goldGradient,
        boxShadow: V5Colors.goldGlow,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: V5Colors.background,
        ),
        child: V5Avatar(imageUrl: imageUrl, size: size - (borderWidth * 2) - 4),
      ),
    );
  }
}

/// Avatar group with gold styling
class V5AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V5AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V5Layout.avatarSmall,
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
                  border: Border.all(color: V5Colors.background, width: 2),
                ),
                child: V5Avatar(
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
                  gradient: V5Colors.goldGradient,
                  shape: BoxShape.circle,
                  border: Border.all(color: V5Colors.background, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: V5Colors.background,
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

