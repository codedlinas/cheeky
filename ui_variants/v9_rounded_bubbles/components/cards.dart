import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V9ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;
  const V9ProfileCard({super.key, required this.imageUrl, required this.name, required this.age, this.bio, this.distance, this.tags});
  @override
  Widget build(BuildContext context) => Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(V9Layout.radiusL), boxShadow: V9Colors.bubbleShadow), child: ClipRRect(borderRadius: BorderRadius.circular(V9Layout.radiusL), child: Stack(fit: StackFit.expand, children: [Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: V9Colors.surfaceAlt, child: const Icon(Icons.person_rounded, size: 80, color: V9Colors.primary))), Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, V9Colors.primary.withOpacity(0.6)], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.5, 1.0]))), Positioned(left: 20, right: 20, bottom: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(name, style: V9Fonts.cardName), const SizedBox(width: 8), Text('$age', style: V9Fonts.cardAge)]), if (distance != null) ...[const SizedBox(height: 4), Row(children: [const Icon(Icons.location_on_rounded, color: Colors.white70, size: 14), const SizedBox(width: 4), Text(distance!, style: V9Fonts.bodyMedium.copyWith(color: Colors.white70))])], if (bio != null) ...[const SizedBox(height: 8), Text(bio!, style: V9Fonts.cardBio, maxLines: 2, overflow: TextOverflow.ellipsis)], if (tags != null && tags!.isNotEmpty) ...[const SizedBox(height: 10), Wrap(spacing: 6, runSpacing: 6, children: tags!.map((tag) => V9Tag(label: tag)).toList())]]))])));
}

class V9Tag extends StatelessWidget {
  final String label;
  const V9Tag({super.key, required this.label});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(V9Layout.radiusXL)), child: Text(label, style: V9Fonts.labelMedium.copyWith(color: Colors.white)));
}

class V9MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final VoidCallback? onTap;
  const V9MatchCard({super.key, required this.imageUrl, required this.name, this.lastMessage, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: V9Colors.surface, borderRadius: BorderRadius.circular(V9Layout.radiusM), boxShadow: V9Colors.softShadow), child: Row(children: [CircleAvatar(radius: V9Layout.avatarMedium / 2, backgroundImage: NetworkImage(imageUrl), backgroundColor: V9Colors.surfaceAlt), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: V9Fonts.titleMedium), if (lastMessage != null) Text(lastMessage!, style: V9Fonts.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis)])), const Icon(Icons.chevron_right_rounded, color: V9Colors.primary)])));
}

class V9NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;
  const V9NewMatchBadge({super.key, required this.imageUrl, required this.name, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Column(children: [Container(padding: const EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [V9Colors.primary, V9Colors.accent])), child: CircleAvatar(radius: 35, backgroundColor: V9Colors.background, child: CircleAvatar(radius: 32, backgroundImage: NetworkImage(imageUrl), backgroundColor: V9Colors.surfaceAlt))), const SizedBox(height: 8), Text(name, style: V9Fonts.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis)]));
}

