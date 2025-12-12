import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/theme/app_theme.dart';
import '../../providers/matches_provider.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(matchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
        centerTitle: true,
      ),
      body: matchesAsync.when(
        data: (matches) {
          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No matches yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start swiping to find your match!',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(matchesProvider.future),
            color: AppTheme.primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                final otherUser = match.otherUser;

                return GestureDetector(
                  onTap: () => context.push('/chat/${match.id}'),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: otherUser?.photoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: otherUser!.photoUrl!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: AppTheme.cardColor,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: AppTheme.cardColor,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 35,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                otherUser?.displayName ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Matched ${timeago.format(match.createdAt)}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(matchesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

