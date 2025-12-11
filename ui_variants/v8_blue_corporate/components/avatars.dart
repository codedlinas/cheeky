import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

class V8Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  const V8Avatar({super.key, this.imageUrl, this.size = V8Layout.avatarMedium, this.showOnline = false});
  @override
  Widget build(BuildContext context) => Stack(children: [Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: V8Colors.border)), child: ClipOval(child: imageUrl != null ? Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder()) : _placeholder())), if (showOnline) Positioned(right: 0, bottom: 0, child: Container(width: size * 0.25, height: size * 0.25, decoration: BoxDecoration(color: V8Colors.success, shape: BoxShape.circle, border: Border.all(color: V8Colors.background, width: 2))))]);
  Widget _placeholder() => Container(color: V8Colors.surfaceAlt, child: Icon(Icons.person_outline, size: size * 0.5, color: V8Colors.textMuted));
}

class V8AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;
  const V8AvatarGroup({super.key, required this.imageUrls, this.size = V8Layout.avatarSmall, this.maxDisplay = 3});
  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;
    return SizedBox(width: size + (displayCount - 1) * (size * 0.6) + (remaining > 0 ? size * 0.6 : 0), height: size, child: Stack(children: [...List.generate(displayCount, (index) => Positioned(left: index * (size * 0.6), child: Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: V8Colors.background, width: 2)), child: V8Avatar(imageUrl: imageUrls[index], size: size)))), if (remaining > 0) Positioned(left: displayCount * (size * 0.6), child: Container(width: size, height: size, decoration: BoxDecoration(color: V8Colors.primary, shape: BoxShape.circle, border: Border.all(color: V8Colors.background, width: 2)), child: Center(child: Text('+$remaining', style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.bold)))))]));
  }
}

