import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

class V8PageTransitions {
  static PageRouteBuilder<T> material<T>(Widget page) => PageRouteBuilder<T>(pageBuilder: (context, animation, secondaryAnimation) => page, transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic), child: child), transitionDuration: const Duration(milliseconds: 250));
}

class V8BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V8NavItem> items;
  const V8BottomNavBar({super.key, required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: V8Layout.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(color: V8Colors.background, border: Border(top: BorderSide(color: V8Colors.border))),
      child: SafeArea(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(isSelected ? item.activeIcon ?? item.icon : item.icon, color: isSelected ? V8Colors.primary : V8Colors.textMuted, size: 24),
                const SizedBox(height: 4),
                Text(item.label, style: V8Fonts.labelMedium.copyWith(color: isSelected ? V8Colors.primary : V8Colors.textMuted, fontSize: 10)),
              ]),
            ),
          );
        })),
      ),
    );
  }
}

class V8NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  const V8NavItem({required this.icon, this.activeIcon, required this.label});
}

class V8AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  const V8AppBar({super.key, this.title, this.actions, this.leading});
  @override
  Widget build(BuildContext context) => AppBar(title: title != null ? Text(title!, style: V8Fonts.titleLarge) : null, backgroundColor: V8Colors.background, elevation: 0, leading: leading, actions: actions);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class V8MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;
  const V8MatchReveal({super.key, required this.child, this.onComplete});
  @override
  State<V8MatchReveal> createState() => _V8MatchRevealState();
}

class _V8MatchRevealState extends State<V8MatchReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() { super.initState(); _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this); _controller.forward().then((_) => widget.onComplete?.call()); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ScaleTransition(scale: Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)), child: FadeTransition(opacity: _controller, child: widget.child));
}

