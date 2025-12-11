import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

class V7Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasBorder;

  const V7Avatar({super.key, this.imageUrl, this.size = V7Layout.avatarMedium, this.showOnline = false, this.hasBorder = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(border: hasBorder ? Border.all(color: V7Colors.primary, width: 3) : null),
          child: ClipRRect(
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder())
                : _placeholder(),
          ),
        ),
        if (showOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(width: size * 0.25, height: size * 0.25, decoration: BoxDecoration(color: V7Colors.success, border: Border.all(color: V7Colors.background, width: 2))),
          ),
      ],
    );
  }

  Widget _placeholder() => Container(color: V7Colors.surface, child: Icon(Icons.person, size: size * 0.5, color: V7Colors.textMuted));
}

class V7AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;

  const V7AvatarGroup({super.key, required this.imageUrls, this.size = V7Layout.avatarSmall, this.maxDisplay = 3});

  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;

    return SizedBox(
      width: size + (displayCount - 1) * (size * 0.6) + (remaining > 0 ? size * 0.6 : 0),
      height: size,
      child: Stack(
        children: [
          ...List.generate(displayCount, (index) => Positioned(left: index * (size * 0.6), child: Container(decoration: BoxDecoration(border: Border.all(color: V7Colors.background, width: 2)), child: V7Avatar(imageUrl: imageUrls[index], size: size)))),
          if (remaining > 0)
            Positioned(
              left: displayCount * (size * 0.6),
              child: Container(
                width: size,
                height: size,
                color: V7Colors.primary,
                child: Center(child: Text('+$remaining', style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.bold))),
              ),
            ),
        ],
      ),
    );
  }
}

