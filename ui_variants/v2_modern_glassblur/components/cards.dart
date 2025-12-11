import 'package:flutter/material.dart';
import 'dart:ui';
import '../colors.dart';
import '../fonts.dart';
import '../layout.dart';

/// V2 Modern Glassblur - Card Components

class V2ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String? bio;
  final String? distance;
  final List<String>? tags;

  const V2ProfileCard({
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
        borderRadius: BorderRadius.circular(V2Layout.radiusL),
        boxShadow: V2Colors.glassShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V2Layout.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Profile Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: V2Colors.surface,
                child: const Icon(Icons.person, size: 100, color: V2Colors.textMuted),
              ),
            ),
            
            // Glass overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Age
                        Row(
                          children: [
                            Text(name, style: V2Fonts.cardName),
                            const SizedBox(width: 10),
                            Text('$age', style: V2Fonts.cardAge),
                          ],
                        ),
                        
                        // Distance
                        if (distance != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, 
                                color: V2Colors.accent, size: 18),
                              const SizedBox(width: 4),
                              Text(distance!, 
                                style: V2Fonts.bodyMedium.copyWith(color: V2Colors.accent)),
                            ],
                          ),
                        ],
                        
                        // Bio
                        if (bio != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            bio!,
                            style: V2Fonts.cardBio,
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
                            children: tags!.map((tag) => V2Tag(label: tag)).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class V2Tag extends StatelessWidget {
  final String label;

  const V2Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(V2Layout.radiusCircle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: V2Colors.glassGradient,
            borderRadius: BorderRadius.circular(V2Layout.radiusCircle),
            border: Border.all(color: V2Colors.glassBorder),
          ),
          child: Text(
            label,
            style: V2Fonts.labelMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// Match Card with glass effect
class V2MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? lastMessage;
  final DateTime? lastActive;
  final VoidCallback? onTap;

  const V2MatchCard({
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V2Layout.radiusM),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: GlassDecoration(borderRadius: V2Layout.radiusM),
            child: Row(
              children: [
                // Avatar with glow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: V2Colors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: V2Layout.avatarMedium / 2,
                    backgroundImage: NetworkImage(imageUrl),
                    onBackgroundImageError: (_, __) {},
                    backgroundColor: V2Colors.surface,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: V2Fonts.titleMedium),
                      if (lastMessage != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          lastMessage!,
                          style: V2Fonts.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Arrow
                Icon(Icons.chevron_right_rounded, color: V2Colors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// New Match Badge with glow
class V2NewMatchBadge extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const V2NewMatchBadge({
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
              gradient: V2Colors.primaryGradient,
              boxShadow: V2Colors.glowShadow,
            ),
            child: CircleAvatar(
              radius: 38,
              backgroundColor: V2Colors.background,
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: V2Colors.surface,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: V2Fonts.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

