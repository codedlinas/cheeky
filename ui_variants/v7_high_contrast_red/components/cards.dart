import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

class V7ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V7ProfileCard({super.key, required this.imageUrl, required this.name, required this.age, this.bio, this.distance, this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: V7Colors.sharpShadow),
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: V7Colors.surface, child: const Icon(Icons.person, size: 100, color: V7Colors.textMuted))),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.8)], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.5, 1.0]),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Text(name.toUpperCase(), style: V7Fonts.cardName), const SizedBox(width: 8), Text('$age', style: V7Fonts.cardAge)]),
                  if (distance != null) ...[const SizedBox(height: 4), Row(children: [const Icon(Icons.location_on, color: Colors.white70, size: 16), const SizedBox(width: 4), Text(distance!, style: V7Fonts.bodyMedium.copyWith(color: Colors.white70))])],
                  if (bio != null) ...[const SizedBox(height: 8), Text(bio!, style: V7Fonts.cardBio, maxLines: 2, overflow: TextOverflow.ellipsis)],
                  if (tags != null && tags!.isNotEmpty) ...[const SizedBox(height: 10), Wrap(spacing: 6, runSpacing: 6, children: tags!.map((tag) => V7Tag(label: tag)).toList())],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class V7Tag extends StatelessWidget {
  final String label;
  const V7Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
      child: Text(label.toUpperCase(), style: V7Fonts.labelMedium.copyWith(color: Colors.white, letterSpacing: 1)),
    );
  }
}

class V7MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final VoidCallback? onTap;

  const V7MatchCard({super.key, required this.imageUrl, required this.name, this.lastMessage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: V7Colors.surface, border: Border.all(color: V7Colors.textPrimary, width: 2)),
        child: Row(
          children: [
            CircleAvatar(radius: V7Layout.avatarMedium / 2, backgroundImage: NetworkImage(imageUrl), backgroundColor: V7Colors.surface),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name.toUpperCase(), style: V7Fonts.titleMedium), if (lastMessage != null) Text(lastMessage!, style: V7Fonts.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis)])),
            const Icon(Icons.chevron_right, color: V7Colors.textPrimary),
          ],
        ),
      ),
    );
  }
}

class V7NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V7NewMatchBadge({super.key, required this.imageUrl, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all(color: V7Colors.primary, width: 3)),
            child: CircleAvatar(radius: 32, backgroundImage: NetworkImage(imageUrl), backgroundColor: V7Colors.surface),
          ),
          const SizedBox(height: 6),
          Text(name.toUpperCase(), style: V7Fonts.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

