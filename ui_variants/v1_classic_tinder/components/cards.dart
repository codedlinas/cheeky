import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V1 Classic Tinder - Card Components

class V1ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V1ProfileCard({
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
        borderRadius: BorderRadius.circular(V1Layout.radiusL),
        boxShadow: V1Colors.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V1Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V1Colors.surface,
                child: const Icon(Icons.person, size: 100, color: V1Colors.textMuted),
              ),
            ),
            
            // Gradient Overlay
            Container(decoration: const BoxDecoration(gradient: V1Colors.cardOverlayGradient)),
            
            // Profile Info
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Age
                  Row(
                    children: [
                      Text(name, style: V1Fonts.cardName),
                      const SizedBox(width: 8),
                      Text('$age', style: V1Fonts.cardAge),
                    ],
                  ),
                  
                  // Distance
                  if (distance != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text(distance!, style: V1Fonts.bodyMedium.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ],
                  
                  // Bio
                  if (bio != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      bio!,
                      style: V1Fonts.cardBio,
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
                      children: tags!.map((tag) => V1Tag(label: tag)).toList(),
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

class V1Tag extends StatelessWidget {
  final String label;

  const V1Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(V1Layout.radiusCircle),
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        label,
        style: V1Fonts.labelMedium.copyWith(color: Colors.white),
      ),
    );
  }
}

/// Match Card (displayed in matches list)
class V1MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final DateTime? lastActive;
  final VoidCallback? onTap;

  const V1MatchCard({
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: V1Colors.card,
          borderRadius: BorderRadius.circular(V1Layout.radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: V1Layout.avatarMedium / 2,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (_, __) {},
              backgroundColor: V1Colors.surface,
            ),
            const SizedBox(width: 12),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: V1Fonts.titleMedium),
                  if (lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      lastMessage!,
                      style: V1Fonts.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            
            // Arrow
            const Icon(Icons.chevron_right, color: V1Colors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// New Match Badge
class V1NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V1NewMatchBadge({
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
              gradient: V1Colors.primaryGradient,
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: V1Colors.surface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: V1Fonts.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

