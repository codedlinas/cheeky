import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

class V9PageTransitions {
  static PageRouteBuilder<T> spring<T>(Widget page) => PageRouteBuilder<T>(pageBuilder: (context, animation, secondaryAnimation) => page, transitionsBuilder: (context, animation, secondaryAnimation, child) => ScaleTransition(scale: Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)), child: FadeTransition(opacity: animation, child: child)), transitionDuration: const Duration(milliseconds: 500));
}

class V9BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V9NavItem> items;
  const V9BottomNavBar({super.key, required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom + 12),
    height: V9Layout.bottomNavHeight,
    decoration: BoxDecoration(color: V9Colors.surface, borderRadius: BorderRadius.circular(V9Layout.radiusXL), boxShadow: V9Colors.bubbleShadow),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) {
      final item = items[index];
      final isSelected = index == currentIndex;
      return GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: isSelected ? V9Colors.primary.withOpacity(0.15) : Colors.transparent, borderRadius: BorderRadius.circular(30)),
          child: AnimatedScale(scale: isSelected ? 1.15 : 1.0, duration: const Duration(milliseconds: 200), curve: Curves.elasticOut, child: Icon(isSelected ? item.activeIcon ?? item.icon : item.icon, color: isSelected ? V9Colors.primary : V9Colors.textMuted, size: 26)),
        ),
      );
    })),
  );
}

class V9NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  const V9NavItem({required this.icon, this.activeIcon, required this.label});
}

class V9AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  const V9AppBar({super.key, this.title, this.actions, this.leading});
  @override
  Widget build(BuildContext context) => AppBar(title: title != null ? Text(title!, style: V9Fonts.titleLarge) : null, centerTitle: true, backgroundColor: Colors.transparent, elevation: 0, leading: leading, actions: actions);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class V9MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;
  const V9MatchReveal({super.key, required this.child, this.onComplete});
  @override
  State<V9MatchReveal> createState() => _V9MatchRevealState();
}

class _V9MatchRevealState extends State<V9MatchReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() { super.initState(); _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this); _controller.forward().then((_) => widget.onComplete?.call()); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ScaleTransition(scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut)), child: widget.child);
}

