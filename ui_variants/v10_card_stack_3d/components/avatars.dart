import 'package:flutter/material.dart';
import '../colors.dart';
import '../layout.dart';

class V10Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showOnline;
  final bool hasGlow;
  const V10Avatar({super.key, this.imageUrl, this.size = V10Layout.avatarMedium, this.showOnline = false, this.hasGlow = false});
  @override
  Widget build(BuildContext context) => Stack(children: [Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: hasGlow ? V10Colors.glowShadow : null), child: ClipOval(child: imageUrl != null ? Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder()) : _placeholder())), if (showOnline) Positioned(right: 0, bottom: 0, child: Container(width: size * 0.28, height: size * 0.28, decoration: BoxDecoration(color: V10Colors.success, shape: BoxShape.circle, border: Border.all(color: V10Colors.background, width: 2), boxShadow: [BoxShadow(color: V10Colors.success.withOpacity(0.5), blurRadius: 6)])))]);
  Widget _placeholder() => Container(color: V10Colors.surfaceLight, child: Icon(Icons.person_rounded, size: size * 0.5, color: V10Colors.primary));
}

class V10GradientAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  const V10GradientAvatar({super.key, this.imageUrl, this.size = V10Layout.avatarLarge});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [V10Colors.primary, V10Colors.accent]), boxShadow: V10Colors.glowShadow), child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(shape: BoxShape.circle, color: V10Colors.background), child: V10Avatar(imageUrl: imageUrl, size: size - 10)));
}

class V10AvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final double size;
  final int maxDisplay;
  const V10AvatarGroup({super.key, required this.imageUrls, this.size = V10Layout.avatarSmall, this.maxDisplay = 3});
  @override
  Widget build(BuildContext context) {
    final displayCount = imageUrls.length > maxDisplay ? maxDisplay : imageUrls.length;
    final remaining = imageUrls.length - maxDisplay;
    return SizedBox(width: size + (displayCount - 1) * (size * 0.6) + (remaining > 0 ? size * 0.6 : 0), height: size, child: Stack(children: [...List.generate(displayCount, (index) => Positioned(left: index * (size * 0.6), child: Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: V10Colors.background, width: 2)), child: V10Avatar(imageUrl: imageUrls[index], size: size)))), if (remaining > 0) Positioned(left: displayCount * (size * 0.6), child: Container(width: size, height: size, decoration: BoxDecoration(gradient: LinearGradient(colors: [V10Colors.primary, V10Colors.accent]), shape: BoxShape.circle, border: Border.all(color: V10Colors.background, width: 2)), child: Center(child: Text('+$remaining', style: TextStyle(color: Colors.white, fontSize: size * 0.35, fontWeight: FontWeight.bold)))))]));
  }
}

