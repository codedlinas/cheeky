import 'package:flutter/material.dart';
import 'dart:ui';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

/// V2 Modern Glassblur - Navigation
/// Features: Floating glass bottom bar, fade + scale transitions

class V2PageTransitions {
  /// Fade with scale transition
  static PageRouteBuilder<T> fadeScale<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween = Tween<double>(begin: 0.95, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  /// Blur fade transition
  static PageRouteBuilder<T> blurFade<T>(Widget page) {
    return PageRouteBuilder<T>(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: (1 - animation.value) * 10,
                sigmaY: (1 - animation.value) * 10,
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Slide up with fade
  static PageRouteBuilder<T> slideUpFade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}

/// V2 Floating Glass Bottom Navigation Bar
class V2BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V2NavItem> items;

  const V2BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(V2Layout.radiusXL),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: V2Layout.bottomNavHeight,
            decoration: GlassDecoration(borderRadius: V2Layout.radiusXL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == currentIndex;
                
                return _V2NavItem(
                  icon: item.icon,
                  activeIcon: item.activeIcon ?? item.icon,
                  label: item.label,
                  isSelected: isSelected,
                  onTap: () => onTap(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class V2NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const V2NavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class _V2NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _V2NavItem({
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
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? V2Colors.primary.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? V2Colors.primary : V2Colors.textMuted,
                size: isSelected ? 28 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: V2Fonts.labelMedium.copyWith(
                color: isSelected ? V2Colors.primary : V2Colors.textMuted,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: isSelected ? 11 : 10,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

/// V2 Glass App Bar
class V2AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool transparent;

  const V2AppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.transparent = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!, style: V2Fonts.titleLarge) : null),
      centerTitle: true,
      backgroundColor: transparent ? Colors.transparent : V2Colors.surface,
      elevation: 0,
      leading: leading,
      actions: actions,
      iconTheme: const IconThemeData(color: V2Colors.textPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Match reveal animation with particles
class V2MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;

  const V2MatchReveal({
    super.key,
    required this.child,
    this.onComplete,
  });

  @override
  State<V2MatchReveal> createState() => _V2MatchRevealState();
}

class _V2MatchRevealState extends State<V2MatchReveal>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );
    
    _scaleController.forward();
    _glowController.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _glowController]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: V2Colors.primary.withOpacity(_glowAnimation.value * 0.5),
                blurRadius: 50 * _glowAnimation.value,
                spreadRadius: 20 * _glowAnimation.value,
              ),
            ],
          ),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

