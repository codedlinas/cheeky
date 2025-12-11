import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

class V9Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasBorder;
  const V9Avatar({super.key, this.imageUrl, this.size = V9Layout.avatarMedium, this.showOnline = false, this.hasBorder = false});
  @override
  Widget build(BuildContext context) => Stack(children: [Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, border: hasBorder ? Border.all(color: V9Colors.primary, width: 3) : null, boxShadow: hasBorder ? V9Colors.bubbleShadow : null), child: ClipOval(child: imageUrl != null ? Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder()) : _placeholder())), if (showOnline) Positioned(right: 0, bottom: 0, child: Container(width: size * 0.28, height: size * 0.28, decoration: BoxDecoration(color: V9Colors.success, shape: BoxShape.circle, border: Border.all(color: V9Colors.background, width: 2))))]);
  Widget _placeholder() => Container(color: V9Colors.surfaceAlt, child: Icon(Icons.person_rounded, size: size * 0.5, color: V9Colors.primary));
}

class V9AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;
  const V9AvatarGroup({super.key, required this.imageUrls, this.size = V9Layout.avatarSmall, this.maxDisplay = 3});
  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;
    return SizedBox(width: size + (displayCount - 1) * (size * 0.65) + (remaining > 0 ? size * 0.65 : 0), height: size, child: Stack(children: [...List.generate(displayCount, (index) => Positioned(left: index * (size * 0.65), child: Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: V9Colors.background, width: 2)), child: V9Avatar(imageUrl: imageUrls[index], size: size)))), if (remaining > 0) Positioned(left: displayCount * (size * 0.65), child: Container(width: size, height: size, decoration: BoxDecoration(gradient: LinearGradient(colors: [V9Colors.primary, V9Colors.accent]), shape: BoxShape.circle, border: Border.all(color: V9Colors.background, width: 2)), child: Center(child: Text('+$remaining', style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.bold)))))]));
  }
}

