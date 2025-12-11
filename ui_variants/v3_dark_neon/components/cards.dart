import 'package:flutter/material.dart';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V3 Dark Neon - Card Components

class V3ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V3ProfileCard({
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
        borderRadius: BorderRadius.circular(V3Layout.radiusL),
        border: Border.all(color: V3Colors.primary.withOpacity(0.5), width: 1),
        boxShadow: V3Colors.neonGlow(V3Colors.primary, intensity: 0.3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V3Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V3Colors.surface,
                child: const Icon(Icons.person, size: 100, color: V3Colors.textMuted),
              ),
            ),
            
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    V3Colors.background.withOpacity(0.8),
                    V3Colors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.4, 0.7, 1.0],
                ),
              ),
            ),
            
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
                      Text(name.toUpperCase(), style: V3Fonts.cardName),
                      const SizedBox(width: 10),
                      Text('$age', style: V3Fonts.cardAge),
                    ],
                  ),
                  
                  // Distance with neon accent
                  if (distance != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: V3Colors.secondary, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          distance!,
                          style: V3Fonts.bodyMedium.copyWith(color: V3Colors.secondary),
                        ),
                      ],
                    ),
                  ],
                  
                  // Bio
                  if (bio != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      bio!,
                      style: V3Fonts.cardBio,
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
                      children: tags!.map((tag) => V3Tag(label: tag)).toList(),
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

class V3Tag extends StatelessWidget {
  final String label;

  const V3Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: V3Colors.surface,
        borderRadius: BorderRadius.circular(V3Layout.radiusS),
        border: Border.all(color: V3Colors.secondary.withOpacity(0.5)),
      ),
      child: Text(
        label.toUpperCase(),
        style: V3Fonts.labelMedium.copyWith(
          color: V3Colors.secondary,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

/// Match Card with neon styling
class V3MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final DateTime? lastActive;
  final VoidCallback? onTap;

  const V3MatchCard({
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
        decoration: NeonBorderDecoration(
          borderRadius: V3Layout.radiusM,
          hasGlow: false,
        ),
        child: Row(
          children: [
            // Avatar with neon ring
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: V3Colors.primary, width: 2),
                boxShadow: V3Colors.neonGlow(V3Colors.primary, intensity: 0.3),
              ),
              child: CircleAvatar(
                radius: V3Layout.avatarMedium / 2 - 2,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {},
                backgroundColor: V3Colors.surface,
              ),
            ),
            const SizedBox(width: 12),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: V3Fonts.titleMedium.copyWith(letterSpacing: 1),
                  ),
                  if (lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      lastMessage!,
                      style: V3Fonts.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            
            // Arrow
            Icon(Icons.chevron_right, color: V3Colors.primary),
          ],
        ),
      ),
    );
  }
}

/// New Match Badge
class V3NewMatchBadge extends StatefulWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V3NewMatchBadge({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  State<V3NewMatchBadge> createState() => _V3NewMatchBadgeState();
}

class _V3NewMatchBadgeState extends State<V3NewMatchBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: V3Colors.primaryGradient,
                  boxShadow: V3Colors.neonGlow(
                    V3Colors.primary,
                    intensity: 0.5 + (_controller.value * 0.5),
                  ),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: V3Colors.background,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(widget.imageUrl),
                    backgroundColor: V3Colors.surface,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.name.toUpperCase(),
                style: V3Fonts.labelMedium.copyWith(letterSpacing: 1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}

