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
    final navStyle = getNavBarStyle(variant);
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      extendBody: navStyle.isFloating,
      bottomNavigationBar: _buildNavBar(context, variant, navStyle, selectedIndex),
    );
  }

  Widget _buildNavBar(BuildContext context, AppThemeVariant variant, NavBarStyle style, int selectedIndex) {
    // Get icons based on style
    final activeIcons = style.useCustomIcons && style.customActiveIcons != null
        ? style.customActiveIcons!
        : [Icons.local_fire_department, Icons.favorite, Icons.person];
    final inactiveIcons = style.useCustomIcons && style.customInactiveIcons != null
        ? style.customInactiveIcons!
        : [Icons.local_fire_department_outlined, Icons.favorite_border, Icons.person_outline];
    final labels = style.useCustomLabels && style.customLabels != null
        ? style.customLabels!
        : ['Discover', 'Matches', 'Profile'];

    Widget navBar;

    switch (variant) {
      case AppThemeVariant.v2ModernGlassblur:
        navBar = _buildGlassNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      case AppThemeVariant.v3DarkNeon:
        navBar = _buildNeonNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      case AppThemeVariant.v5LuxuryGoldBlack:
        navBar = _buildLuxuryNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      case AppThemeVariant.v6PlayfulPastel:
        navBar = _buildPastelNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      case AppThemeVariant.v7HighContrastRed:
        navBar = _buildBoldNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      case AppThemeVariant.v9RoundedBubbles:
        navBar = _buildBubbleNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
        break;
      default:
        navBar = _buildDefaultNavBar(context, style, selectedIndex, activeIcons, inactiveIcons, labels);
    }

    if (style.isFloating) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: navBar,
      );
    }

    return navBar;
  }

  Widget _buildDefaultNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => _onItemTapped(context, index),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? activeIcons[index] : inactiveIcons[index],
                        color: isSelected ? style.selectedIconColor : style.unselectedIconColor,
                        size: style.iconSize,
                      ),
                      if (style.showLabels) ...[
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: isSelected ? style.selectedIconColor : style.unselectedIconColor,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(style.borderRadius),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(style.borderRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(context, index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? activeIcons[index] : inactiveIcons[index],
                    color: isSelected ? style.selectedIconColor : style.unselectedIconColor,
                    size: style.iconSize,
                  ),
                  if (isSelected && style.indicatorType == NavIndicatorType.dot)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: style.selectedIconColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNeonNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: style.glowColor ?? style.selectedIconColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = index == selectedIndex;
          final color = isSelected ? style.selectedIconColor : style.unselectedIconColor;
          return GestureDetector(
            onTap: () => _onItemTapped(context, index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: isSelected
                        ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.6),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          )
                        : null,
                    child: Icon(
                      isSelected ? activeIcons[index] : inactiveIcons[index],
                      color: color,
                      size: style.iconSize,
                    ),
                  ),
                  if (style.showLabels) ...[
                    const SizedBox(height: 4),
                    Text(
                      labels[index].toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLuxuryNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    const goldColor = Color(0xFFD4AF37);
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: goldColor, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => _onItemTapped(context, index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? activeIcons[index] : inactiveIcons[index],
                  color: isSelected ? goldColor : Colors.grey[600],
                  size: style.iconSize,
                ),
                const SizedBox(height: 6),
                Text(
                  labels[index].toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? goldColor : Colors.grey[600],
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPastelNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = index == selectedIndex;
          final color = isSelected ? style.selectedIconColor : style.unselectedIconColor;
          return GestureDetector(
            onTap: () => _onItemTapped(context, index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? style.pillColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? activeIcons[index] : inactiveIcons[index],
                    color: color,
                    size: style.iconSize,
                  ),
                  if (isSelected && style.showLabels) ...[
                    const SizedBox(width: 8),
                    Text(
                      labels[index],
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBoldNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return Container(
      height: 75,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => _onItemTapped(context, index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 70,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.white,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? activeIcons[index] : inactiveIcons[index],
                    color: isSelected ? Colors.white : Colors.white,
                    size: style.iconSize,
                  ),
                  if (style.showLabels) ...[
                    const SizedBox(height: 2),
                    Text(
                      labels[index].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBubbleNavBar(
    BuildContext context,
    NavBarStyle style,
    int selectedIndex,
    List<IconData> activeIcons,
    List<IconData> inactiveIcons,
    List<String> labels,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(style.borderRadius),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(style.borderRadius),
          boxShadow: [
            BoxShadow(
              color: style.bubbleColor?.withValues(alpha: 0.3) ?? Colors.teal.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(context, index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                width: isSelected ? 55 : 45,
                height: isSelected ? 55 : 45,
                decoration: BoxDecoration(
                  color: isSelected ? style.bubbleColor : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: style.bubbleColor?.withValues(alpha: 0.4) ?? Colors.teal.withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  isSelected ? activeIcons[index] : inactiveIcons[index],
                  color: isSelected ? Colors.white : style.unselectedIconColor,
                  size: isSelected ? 28 : style.iconSize,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
