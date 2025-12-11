import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

/// V5 Luxury Gold Black - Navigation
/// Elegant gold-accented bottom bar, premium slow-easing transitions

class V5PageTransitions {
  /// Slow elegant fade
  static PageRouteBuilder<T> elegantFade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutQuart),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  /// Scale with gold shimmer hint
  static PageRouteBuilder<T> luxuryScale<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween = Tween<double>(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutQuart));
        
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 450),
    );
  }

  /// Slide from bottom (for modals)
  static PageRouteBuilder<T> slideUp<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutQuart));
        
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: animation.drive(tween), child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 450),
    );
  }
}

/// V5 Gold Bottom Navigation Bar
class V5BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V5NavItem> items;

  const V5BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: V5Layout.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: V5Colors.surface,
        border: Border(
          top: BorderSide(color: V5Colors.gold.withOpacity(0.2), width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            
            return _V5NavItem(
              icon: item.icon,
              activeIcon: item.activeIcon ?? item.icon,
              label: item.label,
              isSelected: isSelected,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class V5NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const V5NavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class _V5NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _V5NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? V5Colors.gold : V5Colors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: V5Fonts.fontFamilySans,
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? V5Colors.gold : V5Colors.textMuted,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// V5 Gold App Bar
class V5AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;

  const V5AppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(
                  title!.toUpperCase(),
                  style: V5Fonts.titleLarge.copyWith(
                    color: V5Colors.gold,
                    letterSpacing: 2,
                  ),
                )
              : null),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: leading,
      actions: actions,
      iconTheme: const IconThemeData(color: V5Colors.gold),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Luxury match reveal
class V5MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;

  const V5MatchReveal({
    super.key,
    required this.child,
    this.onComplete,
  });

  @override
  State<V5MatchReveal> createState() => _V5MatchRevealState();
}

class _V5MatchRevealState extends State<V5MatchReveal>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController.forward();
    _shimmerController.repeat();
    
    Future.delayed(const Duration(milliseconds: 1200), () {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _shimmerController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Gold shimmer ring
            Container(
              width: 250 + (_scaleController.value * 50),
              height: 250 + (_scaleController.value * 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: V5Colors.gold.withOpacity(0.3 * (1 - _scaleController.value * 0.5)),
                  width: 2,
                ),
              ),
            ),
            // Main content
            Transform.scale(
              scale: Curves.elasticOut.transform(_scaleController.value),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: V5Colors.goldGlow,
                ),
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}

