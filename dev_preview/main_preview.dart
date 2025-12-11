/// Cheeky App - Developer Preview Mode
/// 
/// This file provides a developer-only preview mode that:
/// - Loads the app with a selected UI variant
/// - Bypasses onboarding flows
/// - Opens directly to the Home → Swipe screen
/// - Is hot-reload compatible
/// 
/// USAGE:
/// Run with: flutter run -t dev_preview/main_preview.dart
/// 
/// IMPORTANT: This is for development/preview only and should NOT be used in production.

import 'package:flutter/material.dart';
import '../ui_variants/ui_switcher.dart';

// Import variant-specific components for demo
import '../ui_variants/v1_classic_tinder/swipeflow.dart' as v1_swipe;
import '../ui_variants/v1_classic_tinder/components/cards.dart' as v1_cards;
import '../ui_variants/v1_classic_tinder/components/buttons.dart' as v1_buttons;
import '../ui_variants/v1_classic_tinder/navigation.dart' as v1_nav;
import '../ui_variants/v1_classic_tinder/colors.dart' as v1_colors;

import '../ui_variants/v2_modern_glassblur/swipeflow.dart' as v2_swipe;
import '../ui_variants/v2_modern_glassblur/components/cards.dart' as v2_cards;
import '../ui_variants/v2_modern_glassblur/components/buttons.dart' as v2_buttons;
import '../ui_variants/v2_modern_glassblur/navigation.dart' as v2_nav;
import '../ui_variants/v2_modern_glassblur/colors.dart' as v2_colors;

import '../ui_variants/v3_dark_neon/swipeflow.dart' as v3_swipe;
import '../ui_variants/v3_dark_neon/components/cards.dart' as v3_cards;
import '../ui_variants/v3_dark_neon/components/buttons.dart' as v3_buttons;
import '../ui_variants/v3_dark_neon/navigation.dart' as v3_nav;
import '../ui_variants/v3_dark_neon/colors.dart' as v3_colors;

void main() {
  runApp(const CheekyPreviewApp());
}

class CheekyPreviewApp extends StatefulWidget {
  const CheekyPreviewApp({super.key});

  @override
  State<CheekyPreviewApp> createState() => _CheekyPreviewAppState();
}

class _CheekyPreviewAppState extends State<CheekyPreviewApp> {
  UIVariant _currentVariant = activeVariant;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheeky UI Preview',
      debugShowCheckedModeBanner: false,
      theme: getThemeForVariant(_currentVariant),
      home: PreviewHomeScreen(
        currentVariant: _currentVariant,
        onVariantChanged: (variant) => setState(() => _currentVariant = variant),
      ),
    );
  }
}

class PreviewHomeScreen extends StatefulWidget {
  final UIVariant currentVariant;
  final ValueChanged<UIVariant> onVariantChanged;

  const PreviewHomeScreen({
    super.key,
    required this.currentVariant,
    required this.onVariantChanged,
  });

  @override
  State<PreviewHomeScreen> createState() => _PreviewHomeScreenState();
}

class _PreviewHomeScreenState extends State<PreviewHomeScreen> {
  int _currentIndex = 0;
  int _cardIndex = 0;

  // Demo profile data
  final List<Map<String, dynamic>> _demoProfiles = [
    {'name': 'Sarah', 'age': 25, 'bio': 'Adventure seeker & coffee lover ☕', 'distance': '2 km away', 'image': 'https://picsum.photos/400/600?random=1'},
    {'name': 'Emily', 'age': 23, 'bio': 'Music is my therapy 🎵', 'distance': '5 km away', 'image': 'https://picsum.photos/400/600?random=2'},
    {'name': 'Jessica', 'age': 27, 'bio': 'Travel enthusiast ✈️', 'distance': '3 km away', 'image': 'https://picsum.photos/400/600?random=3'},
    {'name': 'Olivia', 'age': 24, 'bio': 'Yoga & wellness 🧘', 'distance': '1 km away', 'image': 'https://picsum.photos/400/600?random=4'},
    {'name': 'Sophia', 'age': 26, 'bio': 'Foodie & Netflix 🍕', 'distance': '4 km away', 'image': 'https://picsum.photos/400/600?random=5'},
  ];

  void _nextCard() {
    if (_cardIndex < _demoProfiles.length - 1) {
      setState(() => _cardIndex++);
    } else {
      setState(() => _cardIndex = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Variant Selector Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('🎨 ', style: TextStyle(fontSize: 24)),
                      Expanded(
                        child: DropdownButton<UIVariant>(
                          value: widget.currentVariant,
                          isExpanded: true,
                          items: allVariants.map((variant) {
                            return DropdownMenuItem(
                              value: variant,
                              child: Text(
                                getVariantName(variant),
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (variant) {
                            if (variant != null) {
                              widget.onVariantChanged(variant);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getVariantDescription(widget.currentVariant),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const Divider(height: 1),
            
            // Main Content Area
            Expanded(
              child: _buildMainContent(),
            ),
            
            // Bottom Navigation Preview
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentIndex) {
      case 0:
        return _buildSwipePreview();
      case 1:
        return _buildMatchesPreview();
      case 2:
        return _buildProfilePreview();
      default:
        return _buildSwipePreview();
    }
  }

  Widget _buildSwipePreview() {
    final profile = _demoProfiles[_cardIndex];
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: _buildProfileCard(profile),
          ),
          const SizedBox(height: 20),
          _buildSwipeActions(),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    // Return a demo card based on active variant
    switch (widget.currentVariant) {
      case UIVariant.v1ClassicTinder:
        return v1_cards.V1ProfileCard(
          imageUrl: profile['image'],
          name: profile['name'],
          age: profile['age'],
          bio: profile['bio'],
          distance: profile['distance'],
        );
      case UIVariant.v2ModernGlassblur:
        return v2_cards.V2ProfileCard(
          imageUrl: profile['image'],
          name: profile['name'],
          age: profile['age'],
          bio: profile['bio'],
          distance: profile['distance'],
        );
      case UIVariant.v3DarkNeon:
        return v3_cards.V3ProfileCard(
          imageUrl: profile['image'],
          name: profile['name'],
          age: profile['age'],
          bio: profile['bio'],
          distance: profile['distance'],
        );
      default:
        // Default fallback card
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(profile['image']),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(profile['name'], style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text('${profile['age']}', style: const TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(profile['bio'], style: const TextStyle(color: Colors.white70, fontSize: 16)),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildSwipeActions() {
    switch (widget.currentVariant) {
      case UIVariant.v1ClassicTinder:
        return v1_buttons.V1SwipeActions(
          onPass: _nextCard,
          onSuperLike: _nextCard,
          onLike: _nextCard,
        );
      case UIVariant.v2ModernGlassblur:
        return v2_buttons.V2SwipeActions(
          onPass: _nextCard,
          onSuperLike: _nextCard,
          onLike: _nextCard,
        );
      case UIVariant.v3DarkNeon:
        return v3_buttons.V3SwipeActions(
          onPass: _nextCard,
          onSuperLike: _nextCard,
          onLike: _nextCard,
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ActionButton(icon: Icons.close, color: Colors.red, onTap: _nextCard),
            const SizedBox(width: 20),
            _ActionButton(icon: Icons.star, color: Colors.blue, onTap: _nextCard),
            const SizedBox(width: 20),
            _ActionButton(icon: Icons.favorite, color: Colors.green, onTap: _nextCard),
          ],
        );
    }
  }

  Widget _buildMatchesPreview() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('New Matches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage('https://picsum.photos/100/100?random=${index + 10}'),
                    ),
                    const SizedBox(height: 8),
                    Text('Match ${index + 1}'),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text('Messages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...List.generate(5, (index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/100/100?random=${index + 20}'),
            ),
            title: Text('Match ${index + 1}'),
            subtitle: const Text('Hey there! 👋'),
            trailing: const Text('2m ago'),
          );
        }),
      ],
    );
  }

  Widget _buildProfilePreview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: const NetworkImage('https://picsum.photos/200/200?random=99'),
          ),
          const SizedBox(height: 16),
          const Text('Your Name, 25', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Your bio goes here...', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          _buildSettingsItem(Icons.edit, 'Edit Profile'),
          _buildSettingsItem(Icons.settings, 'Settings'),
          _buildSettingsItem(Icons.help, 'Help & Support'),
          _buildSettingsItem(Icons.logout, 'Log Out'),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.local_fire_department, isSelected: _currentIndex == 0, onTap: () => setState(() => _currentIndex = 0)),
          _NavItem(icon: Icons.chat_bubble, isSelected: _currentIndex == 1, onTap: () => setState(() => _currentIndex = 1)),
          _NavItem(icon: Icons.person, isSelected: _currentIndex == 2, onTap: () => setState(() => _currentIndex = 2)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Icon(
          icon,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          size: 28,
        ),
      ),
    );
  }
}

