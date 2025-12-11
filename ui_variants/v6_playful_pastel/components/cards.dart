import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V6 Playful Pastel - Card Components

class V6ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V6ProfileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    this.bio,
    this.distance,
    this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(V6Layout.radiusL),
        boxShadow: V6Colors.softShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V6Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V6Colors.primary.withOpacity(0.1),
                child: const Icon(Icons.person_rounded, size: 100, color: V6Colors.primary),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    V6Colors.primary.withOpacity(0.3),
                    V6Colors.primary.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 0.7, 1.0],
                ),
              ),
            ),
            
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: V6Fonts.cardName),
                      const SizedBox(width: 8),
                      Text('$age', style: V6Fonts.cardAge),
                    ],
                  ),
                  
                  if (distance != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text(distance!, style: V6Fonts.bodyMedium.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ],
                  
                  if (bio != null) ...[
                    const SizedBox(height: 8),
                    Text(bio!, style: V6Fonts.cardBio, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                  
                  if (tags != null && tags!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags!.map((tag) => V6Tag(label: tag)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class V6Tag extends StatelessWidget {
  final String label;

  const V6Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(V6Layout.radiusCircle),
      ),
      child: Text(label, style: V6Fonts.labelMedium.copyWith(color: Colors.white)),
    );
  }
}

/// Match Card
class V6MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final VoidCallback? onTap;

  const V6MatchCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.lastMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: V6Colors.surface,
          borderRadius: BorderRadius.circular(V6Layout.radiusM),
          boxShadow: V6Colors.softShadow,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: V6Layout.avatarMedium / 2,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: V6Colors.primary.withOpacity(0.1),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: V6Fonts.titleMedium),
                  if (lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(lastMessage!, style: V6Fonts.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: V6Colors.primary),
          ],
        ),
      ),
    );
  }
}

/// New Match Badge
class V6NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V6NewMatchBadge({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: V6Colors.rainbowPastel,
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: V6Colors.surface,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: V6Colors.primary.withOpacity(0.1),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: V6Fonts.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

