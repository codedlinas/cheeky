import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/theme_provider.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/matches')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/matches');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variant = ref.watch(themeVariantProvider);
    final selectedIndex = _calculateSelectedIndex(context);
    
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildNavBarForVariant(context, variant, selectedIndex),
    );
  }

  Widget _buildNavBarForVariant(BuildContext context, AppThemeVariant variant, int selectedIndex) {
    switch (variant) {
      case AppThemeVariant.v3DarkNeon:
        return _buildCyberpunkNav(context, selectedIndex);
      case AppThemeVariant.v5LuxuryGoldBlack:
        return _buildLuxuryNav(context, selectedIndex);
      case AppThemeVariant.v6PlayfulPastel:
        return _buildPastelNav(context, selectedIndex);
      case AppThemeVariant.v7HighContrastRed:
        return _buildBoldNav(context, selectedIndex);
      case AppThemeVariant.v9RoundedBubbles:
        return _buildBubbleNav(context, selectedIndex);
      case AppThemeVariant.v10CardStack3D:
        return _buildSpaceNav(context, selectedIndex);
      case AppThemeVariant.v2ModernGlassblur:
        return _buildGlassNav(context, selectedIndex);
      default:
        return _buildDefaultNav(context, selectedIndex);
    }
  }

  Widget _buildDefaultNav(BuildContext context, int selectedIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            activeIcon: Icon(Icons.local_fire_department),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCyberpunkNav(BuildContext context, int selectedIndex) {
    final items = [
      {'icon': Icons.radar, 'label': 'DISCOVER'},
      {'icon': Icons.hub, 'label': 'MATCHES'},
      {'icon': Icons.fingerprint, 'label': 'PROFILE'},
    ];
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF00FFFF), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          final color = isSelected ? const Color(0xFF00FFFF) : const Color(0xFF666666);
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: isSelected ? BoxDecoration(
                    border: Border.all(color: const Color(0xFF00FFFF), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00FFFF).withValues(alpha: 0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ) : null,
                  child: Icon(
                    entry.value['icon'] as IconData,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.value['label'] as String,
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLuxuryNav(BuildContext context, int selectedIndex) {
    final items = [
      {'icon': Icons.diamond_outlined, 'label': 'DISCOVER'},
      {'icon': Icons.favorite_border, 'label': 'MATCHES'},
      {'icon': Icons.person_outline, 'label': 'PROFILE'},
    ];
    
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          final color = isSelected ? const Color(0xFFD4AF37) : const Color(0xFF666666);
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected 
                      ? (entry.value['icon'] as IconData == Icons.diamond_outlined ? Icons.diamond : 
                         entry.value['icon'] as IconData == Icons.favorite_border ? Icons.favorite :
                         Icons.person)
                      : entry.value['icon'] as IconData,
                  color: color,
                  size: 22,
                ),
                const SizedBox(height: 6),
                Text(
                  entry.value['label'] as String,
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 20,
                    height: 1,
                    color: const Color(0xFFD4AF37),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPastelNav(BuildContext context, int selectedIndex) {
    final items = [
      {'emoji': '🔥', 'label': 'Explore'},
      {'emoji': '💕', 'label': 'Matches'},
      {'emoji': '🌟', 'label': 'Me'},
    ];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B9D).withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 20 : 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFE4EC) : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entry.value['emoji'] as String,
                    style: const TextStyle(fontSize: 20),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Text(
                      entry.value['label'] as String,
                      style: const TextStyle(
                        color: Color(0xFFFF6B9D),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBoldNav(BuildContext context, int selectedIndex) {
    final items = ['SWIPE', 'MATCH', 'YOU'];
    
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => _onItemTapped(context, entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: isSelected ? Colors.red : Colors.black,
                child: Text(
                  entry.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: isSelected ? 2 : 1,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBubbleNav(BuildContext context, int selectedIndex) {
    final items = [
      {'icon': Icons.explore, 'label': 'Explore'},
      {'icon': Icons.favorite, 'label': 'Likes'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00CEC9).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? const LinearGradient(
                  colors: [Color(0xFF00CEC9), Color(0xFF00B894)],
                ) : null,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    entry.value['icon'] as IconData,
                    color: isSelected ? Colors.white : const Color(0xFF636E72),
                    size: 22,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Text(
                      entry.value['label'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpaceNav(BuildContext context, int selectedIndex) {
    final items = [
      Icons.auto_awesome,
      Icons.favorite,
      Icons.person,
    ];
    
    return Container(
      color: const Color(0xFF0C0015),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                ) : null,
                border: isSelected ? null : Border.all(
                  color: const Color(0xFF333333),
                  width: 1,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: const Color(0xFFA855F7).withValues(alpha: 0.5),
                    blurRadius: 15,
                  ),
                ] : null,
              ),
              child: Icon(
                entry.value,
                color: isSelected ? Colors.white : const Color(0xFF666666),
                size: 24,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGlassNav(BuildContext context, int selectedIndex) {
    final items = [
      Icons.local_fire_department,
      Icons.favorite,
      Icons.person,
    ];
    
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          
          return GestureDetector(
            onTap: () => _onItemTapped(context, entry.key),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                entry.value,
                color: isSelected ? const Color(0xFF6366F1) : Colors.white.withValues(alpha: 0.6),
                size: 26,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

