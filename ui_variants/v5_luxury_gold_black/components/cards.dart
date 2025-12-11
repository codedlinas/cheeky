import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V5 Luxury Gold Black - Card Components

class V5ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V5ProfileCard({
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
        borderRadius: BorderRadius.circular(V5Layout.radiusL),
        boxShadow: V5Colors.luxuryShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V5Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V5Colors.surface,
                child: const Icon(Icons.person, size: 100, color: V5Colors.textMuted),
              ),
            ),
            
            // Luxury gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    V5Colors.background.withOpacity(0.7),
                    V5Colors.background.withOpacity(0.95),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 0.7, 1.0],
                ),
              ),
            ),
            
            // Gold accent line at bottom
            Positioned(
              left: 20,
              right: 20,
              bottom: 100,
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      V5Colors.gold.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            
            // Profile Info
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Age
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(name, style: V5Fonts.cardName),
                      const SizedBox(width: 10),
                      Text('$age', style: V5Fonts.cardAge),
                    ],
                  ),
                  
                  // Distance with gold icon
                  if (distance != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: V5Colors.gold, size: 16),
                        const SizedBox(width: 4),
                        Text(distance!, style: V5Fonts.bodyMedium.copyWith(color: V5Colors.gold)),
                      ],
                    ),
                  ],
                  
                  // Bio
                  if (bio != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      bio!,
                      style: V5Fonts.cardBio,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  // Tags
                  if (tags != null && tags!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags!.map((tag) => V5Tag(label: tag)).toList(),
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

class V5Tag extends StatelessWidget {
  final String label;

  const V5Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: V5Colors.gold.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(V5Layout.radiusS),
      ),
      child: Text(
        label,
        style: V5Fonts.labelMedium.copyWith(color: V5Colors.gold),
      ),
    );
  }
}

/// Match Card with gold accents
class V5MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final DateTime? lastActive;
  final VoidCallback? onTap;

  const V5MatchCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.lastMessage,
    this.lastActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: GoldBorderDecoration(hasGlow: false),
        child: Row(
          children: [
            // Avatar with gold ring
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: V5Colors.gold.withOpacity(0.5), width: 1),
              ),
              child: CircleAvatar(
                radius: V5Layout.avatarMedium / 2 - 2,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {},
                backgroundColor: V5Colors.surface,
              ),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: V5Fonts.titleMedium),
                  if (lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      lastMessage!,
                      style: V5Fonts.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            
            // Gold arrow
            Icon(Icons.chevron_right, color: V5Colors.gold),
          ],
        ),
      ),
    );
  }
}

/// New Match Badge
class V5NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V5NewMatchBadge({
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
              gradient: V5Colors.goldGradient,
              boxShadow: V5Colors.goldGlow,
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: V5Colors.background,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: V5Colors.surface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: V5Fonts.labelMedium.copyWith(color: V5Colors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

