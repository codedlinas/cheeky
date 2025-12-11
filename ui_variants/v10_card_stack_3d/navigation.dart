import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

class V10PageTransitions {
  static PageRouteBuilder<T> parallax<T>(Widget page) => PageRouteBuilder<T>(pageBuilder: (context, animation, secondaryAnimation) => page, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    final slide = Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
    final scale = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
    return FadeTransition(opacity: animation, child: SlideTransition(position: slide, child: ScaleTransition(scale: scale, child: child)));
  }, transitionDuration: const Duration(milliseconds: 350));
}

class V10BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V10NavItem> items;
  const V10BottomNavBar({super.key, required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom + 16),
    height: V10Layout.bottomNavHeight,
    decoration: BoxDecoration(color: V10Colors.surface, borderRadius: BorderRadius.circular(V10Layout.radiusXL), boxShadow: V10Colors.depth3d),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) {
      final item = items[index];
      final isSelected = index == currentIndex;
      return GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: isSelected ? V10Colors.primary.withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(16)),
          child: Icon(isSelected ? item.activeIcon ?? item.icon : item.icon, color: isSelected ? V10Colors.primary : V10Colors.textMuted, size: 26),
        ),
      );
    })),
  );
}

class V10NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  const V10NavItem({required this.icon, this.activeIcon, required this.label});
}

class V10AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  const V10AppBar({super.key, this.title, this.actions, this.leading});
  @override
  Widget build(BuildContext context) => AppBar(title: title != null ? Text(title!, style: V10Fonts.titleLarge) : null, centerTitle: true, backgroundColor: Colors.transparent, elevation: 0, leading: leading, actions: actions);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class V10MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;
  const V10MatchReveal({super.key, required this.child, this.onComplete});
  @override
  State<V10MatchReveal> createState() => _V10MatchRevealState();
}

class _V10MatchRevealState extends State<V10MatchReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() { super.initState(); _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this); _controller.forward().then((_) => widget.onComplete?.call()); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: _controller, builder: (context, child) => Transform(transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY((1 - _controller.value) * 1.5)..scale(0.7 + _controller.value * 0.3), alignment: Alignment.center, child: Opacity(opacity: _controller.value, child: widget.child)));
}

