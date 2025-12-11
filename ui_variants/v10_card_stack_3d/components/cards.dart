import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V10ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;
  const V10ProfileCard({super.key, required this.imageUrl, required this.name, required this.age, this.bio, this.distance, this.tags});
  @override
  Widget build(BuildContext context) => Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(V10Layout.radiusL), boxShadow: V10Colors.depth3d), child: ClipRRect(borderRadius: BorderRadius.circular(V10Layout.radiusL), child: Stack(fit: StackFit.expand, children: [Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: V10Colors.surface, child: const Icon(Icons.person_rounded, size: 80, color: V10Colors.primary))), Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, V10Colors.background.withOpacity(0.9)], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.5, 1.0]))), Positioned(left: 20, right: 20, bottom: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(name, style: V10Fonts.cardName), const SizedBox(width: 10), Text('$age', style: V10Fonts.cardAge)]), if (distance != null) ...[const SizedBox(height: 6), Row(children: [const Icon(Icons.location_on_outlined, color: V10Colors.accent, size: 16), const SizedBox(width: 4), Text(distance!, style: V10Fonts.bodyMedium.copyWith(color: V10Colors.accent))])], if (bio != null) ...[const SizedBox(height: 8), Text(bio!, style: V10Fonts.cardBio, maxLines: 2, overflow: TextOverflow.ellipsis)], if (tags != null && tags!.isNotEmpty) ...[const SizedBox(height: 10), Wrap(spacing: 6, runSpacing: 6, children: tags!.map((tag) => V10Tag(label: tag)).toList())]]))])));
}

class V10Tag extends StatelessWidget {
  final String label;
  const V10Tag({super.key, required this.label});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: V10Colors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(V10Layout.radiusS), border: Border.all(color: V10Colors.primary.withOpacity(0.4))), child: Text(label, style: V10Fonts.labelMedium.copyWith(color: V10Colors.primary)));
}

class V10MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final VoidCallback? onTap;
  const V10MatchCard({super.key, required this.imageUrl, required this.name, this.lastMessage, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: V10Colors.surface, borderRadius: BorderRadius.circular(V10Layout.radiusM), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]), child: Row(children: [CircleAvatar(radius: V10Layout.avatarMedium / 2, backgroundImage: NetworkImage(imageUrl), backgroundColor: V10Colors.surfaceLight), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: V10Fonts.titleMedium), if (lastMessage != null) Text(lastMessage!, style: V10Fonts.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis)])), Icon(Icons.chevron_right_rounded, color: V10Colors.primary)])));
}

class V10NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;
  const V10NewMatchBadge({super.key, required this.imageUrl, required this.name, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Column(children: [Container(padding: const EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [V10Colors.primary, V10Colors.accent]), boxShadow: V10Colors.glowShadow), child: CircleAvatar(radius: 35, backgroundColor: V10Colors.background, child: CircleAvatar(radius: 32, backgroundImage: NetworkImage(imageUrl), backgroundColor: V10Colors.surface))), const SizedBox(height: 8), Text(name, style: V10Fonts.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis)]));
}

