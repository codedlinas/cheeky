import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V8ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;
  const V8ProfileCard({super.key, required this.imageUrl, required this.name, required this.age, this.bio, this.distance, this.tags});
  @override
  Widget build(BuildContext context) => Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(V8Layout.radiusM), boxShadow: V8Colors.elevation4), child: ClipRRect(borderRadius: BorderRadius.circular(V8Layout.radiusM), child: Stack(fit: StackFit.expand, children: [Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: V8Colors.surface, child: const Icon(Icons.person, size: 80, color: V8Colors.textMuted))), Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.7)], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.5, 1.0]))), Positioned(left: 16, right: 16, bottom: 16, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(name, style: V8Fonts.cardName), const SizedBox(width: 8), Text('$age', style: V8Fonts.cardAge)]), if (distance != null) ...[const SizedBox(height: 4), Row(children: [const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14), const SizedBox(width: 4), Text(distance!, style: V8Fonts.bodyMedium.copyWith(color: Colors.white70))])], if (bio != null) ...[const SizedBox(height: 8), Text(bio!, style: V8Fonts.cardBio, maxLines: 2, overflow: TextOverflow.ellipsis)], if (tags != null && tags!.isNotEmpty) ...[const SizedBox(height: 8), Wrap(spacing: 6, runSpacing: 6, children: tags!.map((tag) => V8Tag(label: tag)).toList())]]))])));
}

class V8Tag extends StatelessWidget {
  final String label;
  const V8Tag({super.key, required this.label});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(V8Layout.radiusS)), child: Text(label, style: V8Fonts.labelMedium.copyWith(color: Colors.white)));
}

class V8MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final VoidCallback? onTap;
  const V8MatchCard({super.key, required this.imageUrl, required this.name, this.lastMessage, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: V8Colors.surface, borderRadius: BorderRadius.circular(V8Layout.radiusS), border: Border.all(color: V8Colors.border)), child: Row(children: [CircleAvatar(radius: V8Layout.avatarMedium / 2, backgroundImage: NetworkImage(imageUrl), backgroundColor: V8Colors.surfaceAlt), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: V8Fonts.titleMedium), if (lastMessage != null) Text(lastMessage!, style: V8Fonts.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis)])), const Icon(Icons.chevron_right, color: V8Colors.textMuted)])));
}

class V8NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;
  const V8NewMatchBadge({super.key, required this.imageUrl, required this.name, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Column(children: [Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: V8Colors.primary, width: 2)), child: CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl), backgroundColor: V8Colors.surfaceAlt)), const SizedBox(height: 6), Text(name, style: V8Fonts.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis)]));
}

