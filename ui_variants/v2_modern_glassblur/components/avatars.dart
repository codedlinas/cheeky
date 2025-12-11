import 'package:flutter/material.dart';
import 'dart:ui';
import '../colors.dart';
import '../layout.dart';

/// V2 Modern Glassblur - Avatar Components

class V2Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasGlow;

  const V2Avatar({
    super.key,
    this.imageUrl,
    this.size = V2Layout.avatarMedium,
    this.showOnline = false,
    this.hasGlow = false,
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
            boxShadow: hasGlow ? V2Colors.glowShadow : null,
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
                color: V2Colors.success,
                shape: BoxShape.circle,
                border: Border.all(color: V2Colors.background, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: V2Colors.success.withOpacity(0.5),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: GlassDecoration(borderRadius: 100),
          child: Icon(
            Icons.person_rounded,
            size: size * 0.5,
            color: V2Colors.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Gradient bordered avatar with glow
class V2GradientAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double borderWidth;

  const V2GradientAvatar({
    super.key,
    this.imageUrl,
    this.size = V2Layout.avatarLarge,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: V2Colors.primaryGradient,
        boxShadow: V2Colors.glowShadow,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: V2Colors.background,
        ),
        child: V2Avatar(imageUrl: imageUrl, size: size - (borderWidth * 2) - 4),
      ),
    );
  }
}

/// Avatar group with glass overlay
class V2AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V2AvatarGroup({
    super.key,
    required this.imageUrls,
    this.size = V2Layout.avatarSmall,
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
                  border: Border.all(color: V2Colors.background, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: V2Colors.primary.withOpacity(0.2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: V2Avatar(
                  imageUrl: imageUrls[index],
                  size: size,
                ),
              ),
            );
          }),
          if (remaining > 0)
            Positioned(
              left: displayCount * (size * 0.65),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      gradient: V2Colors.primaryGradient,
                      shape: BoxShape.circle,
                      border: Border.all(color: V2Colors.background, width: 2),
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
              ),
            ),
        ],
      ),
    );
  }
}

