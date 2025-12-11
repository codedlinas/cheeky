import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

/// V4 Minimal Soft - Navigation
/// Clean bottom bar, simple fade transitions

class V4PageTransitions {
  /// Simple fade
  static PageRouteBuilder<T> fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  /// Subtle slide up
  static PageRouteBuilder<T> slideUp<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: const Offset(0, 0.05), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut));
        
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: animation.drive(tween), child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  /// No transition for tabs
  static PageRouteBuilder<T> none<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
    );
  }
}

/// V4 Clean Bottom Navigation Bar
class V4BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V4NavItem> items;

  const V4BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: V4Layout.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: V4Colors.surface,
        border: Border(top: BorderSide(color: V4Colors.border, width: 1)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            
            return _V4NavItem(
              icon: item.icon,
              activeIcon: item.activeIcon ?? item.icon,
              isSelected: isSelected,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class V4NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const V4NavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class _V4NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _V4NavItem({
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          child: Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? V4Colors.primary : V4Colors.textMuted,
            size: 24,
          ),
        ),
      ),
    );
  }
}

/// V4 Clean App Bar
class V4AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showDivider;

  const V4AppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: titleWidget ?? (title != null ? Text(title!, style: V4Fonts.titleLarge) : null),
          centerTitle: true,
          backgroundColor: V4Colors.background,
          elevation: 0,
          leading: leading,
          actions: actions,
          iconTheme: const IconThemeData(color: V4Colors.textPrimary),
        ),
        if (showDivider)
          const Divider(height: 1, color: V4Colors.border),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (showDivider ? 1 : 0),
  );
}

/// Simple match reveal
class V4MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;

  const V4MatchReveal({
    super.key,
    required this.child,
    this.onComplete,
  });

  @override
  State<V4MatchReveal> createState() => _V4MatchRevealState();
}

class _V4MatchRevealState extends State<V4MatchReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

