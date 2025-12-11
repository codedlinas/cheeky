import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

/// V6 Playful Pastel - Avatar Components

class V6Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final Color? borderColor;

  const V6Avatar({
    super.key,
    this.imageUrl,
    this.size = V6Layout.avatarMedium,
    this.showOnline = false,
    this.borderColor,
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
            border: borderColor != null ? Border.all(color: borderColor!, width: 3) : null,
            boxShadow: V6Colors.softShadow,
          ),
          child: ClipOval(
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder())
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
                color: V6Colors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: V6Colors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: V6Colors.primary.withOpacity(0.1),
      child: Icon(Icons.person_rounded, size: size * 0.5, color: V6Colors.primary),
    );
  }
}

/// Rainbow gradient avatar
class V6RainbowAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const V6RainbowAvatar({
    super.key,
    this.imageUrl,
    this.size = V6Layout.avatarLarge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: V6Colors.rainbowPastel,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: V6Colors.surface,
        ),
        child: V6Avatar(imageUrl: imageUrl, size: size - 12),
      ),
    );
  }
}

/// Avatar group
class V6AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V6AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V6Layout.avatarSmall,
    this.maxDisplay = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;
    final colors = [V6Colors.primary, V6Colors.purple, V6Colors.blue];

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
                  border: Border.all(color: V6Colors.surface, width: 2),
                ),
                child: V6Avatar(
                  imageUrl: imageUrls[index],
                  size: size,
                  borderColor: colors[index % colors.length],
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
                  gradient: V6Colors.sunsetPastel,
                  shape: BoxShape.circle,
                  border: Border.all(color: V6Colors.surface, width: 2),
                ),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

