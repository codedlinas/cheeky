import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

class V7PageTransitions {
  static PageRouteBuilder<T> snap<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
      },
      transitionDuration: const Duration(milliseconds: 150),
    );
  }
}

class V7BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V7NavItem> items;

  const V7BottomNavBar({super.key, required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: V7Layout.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(color: V7Colors.surface, border: Border(top: BorderSide(color: V7Colors.textPrimary, width: 2))),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isSelected ? V7Colors.primary : Colors.transparent,
                child: Icon(isSelected ? item.activeIcon ?? item.icon : item.icon, color: isSelected ? Colors.white : V7Colors.textMuted, size: 26),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class V7NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  const V7NavItem({required this.icon, this.activeIcon, required this.label});
}

class V7AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const V7AppBar({super.key, this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!.toUpperCase(), style: V7Fonts.titleLarge) : null,
      centerTitle: true,
      backgroundColor: V7Colors.background,
      elevation: 0,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class V7MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;
  const V7MatchReveal({super.key, required this.child, this.onComplete});

  @override
  State<V7MatchReveal> createState() => _V7MatchRevealState();
}

class _V7MatchRevealState extends State<V7MatchReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _controller.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: Tween<double>(begin: 0.9, end: 1.0).animate(_controller), child: widget.child);
  }
}

