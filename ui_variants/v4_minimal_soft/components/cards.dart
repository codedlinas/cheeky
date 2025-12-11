import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V4 Minimal Soft - Card Components

class V4ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V4ProfileCard({
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
        borderRadius: BorderRadius.circular(V4Layout.radiusL),
        border: Border.all(color: V4Colors.border, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V4Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V4Colors.surfaceAlt,
                child: const Icon(Icons.person, size: 80, color: V4Colors.textMuted),
              ),
            ),
            
            // Subtle gradient overlay
            Container(decoration: const BoxDecoration(gradient: V4Colors.cardOverlay)),
            
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
                      Text(name, style: V4Fonts.cardName),
                      const SizedBox(width: 8),
                      Text('$age', style: V4Fonts.cardAge),
                    ],
                  ),
                  
                  // Distance
                  if (distance != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(distance!, style: V4Fonts.bodyMedium.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ],
                  
                  // Bio
                  if (bio != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      bio!,
                      style: V4Fonts.cardBio,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  // Tags
                  if (tags != null && tags!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags!.map((tag) => V4Tag(label: tag)).toList(),
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

class V4Tag extends StatelessWidget {
  final String label;

  const V4Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(V4Layout.radiusS),
      ),
      child: Text(
        label,
        style: V4Fonts.labelMedium.copyWith(color: Colors.white),
      ),
    );
  }
}

/// Clean Match Card
class V4MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final DateTime? lastActive;
  final VoidCallback? onTap;

  const V4MatchCard({
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
          color: V4Colors.surface,
          borderRadius: BorderRadius.circular(V4Layout.radiusM),
          border: Border.all(color: V4Colors.borderLight, width: 1),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: V4Layout.avatarMedium / 2,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (_, __) {},
              backgroundColor: V4Colors.surfaceAlt,
            ),
            const SizedBox(width: 12),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: V4Fonts.titleMedium),
                  if (lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      lastMessage!,
                      style: V4Fonts.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            
            // Arrow
            const Icon(Icons.chevron_right, color: V4Colors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

/// New Match Badge
class V4NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V4NewMatchBadge({
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
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: V4Colors.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: V4Colors.surfaceAlt,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: V4Fonts.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

