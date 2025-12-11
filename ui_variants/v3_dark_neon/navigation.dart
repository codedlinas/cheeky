import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';
import 'layout.dart';

/// V3 Dark Neon - Navigation
/// Features: Neon-bordered bottom bar, glitch transitions

class V3PageTransitions {
  /// Glitch-like transition
  static PageRouteBuilder<T> glitch<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            final progress = animation.value;
            
            // Glitch effect with slight offset
            final offset = (1 - progress) * 5;
            
            return Stack(
              children: [
                // Red channel offset
                Positioned(
                  left: offset,
                  child: Opacity(
                    opacity: 0.5 * (1 - progress),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.red,
                        BlendMode.modulate,
                      ),
                      child: child,
                    ),
                  ),
                ),
                // Cyan channel offset
                Positioned(
                  right: offset,
                  child: Opacity(
                    opacity: 0.5 * (1 - progress),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.cyan,
                        BlendMode.modulate,
                      ),
                      child: child,
                    ),
                  ),
                ),
                // Main content
                Opacity(opacity: progress, child: child),
              ],
            );
          },
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Neon flicker fade
  static PageRouteBuilder<T> neonFade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Slide with neon trail
  static PageRouteBuilder<T> slideWithTrail<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnim = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
        
        return SlideTransition(
          position: slideAnim,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: V3Colors.primary.withOpacity(0.5 * (1 - animation.value)),
                  blurRadius: 30,
                  offset: const Offset(-20, 0),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}

/// V3 Neon Bottom Navigation Bar
class V3BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<V3NavItem> items;

  const V3BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      height: V3Layout.bottomNavHeight,
      decoration: BoxDecoration(
        color: V3Colors.surface,
        borderRadius: BorderRadius.circular(V3Layout.radiusM),
        border: Border.all(color: V3Colors.primary.withOpacity(0.5), width: 1),
        boxShadow: V3Colors.neonGlow(V3Colors.primary, intensity: 0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          
          return _V3NavItem(
            icon: item.icon,
            activeIcon: item.activeIcon ?? item.icon,
            label: item.label,
            isSelected: isSelected,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class V3NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const V3NavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class _V3NavItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _V3NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_V3NavItem> createState() => _V3NavItemState();
}

class _V3NavItemState extends State<_V3NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    if (widget.isSelected) _pulseController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_V3NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final glowIntensity = widget.isSelected ? 0.5 + (_pulseController.value * 0.5) : 0.0;
          
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: widget.isSelected
                      ? BoxDecoration(
                          boxShadow: V3Colors.neonGlow(V3Colors.primary, intensity: glowIntensity),
                        )
                      : null,
                  child: Icon(
                    widget.isSelected ? widget.activeIcon : widget.icon,
                    color: widget.isSelected ? V3Colors.primary : V3Colors.textMuted,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: widget.isSelected
                      ? V3Fonts.neonText(V3Colors.primary, fontSize: 10)
                      : V3Fonts.labelMedium.copyWith(color: V3Colors.textMuted),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// V3 Neon App Bar
class V3AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;

  const V3AppBar({
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
                  style: V3Fonts.neonText(V3Colors.primary, fontSize: 18),
                )
              : null),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: leading,
      actions: actions,
      iconTheme: const IconThemeData(color: V3Colors.textPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Neon burst match reveal
class V3MatchReveal extends StatefulWidget {
  final Widget child;
  final VoidCallback? onComplete;

  const V3MatchReveal({
    super.key,
    required this.child,
    this.onComplete,
  });

  @override
  State<V3MatchReveal> createState() => _V3MatchRevealState();
}

class _V3MatchRevealState extends State<V3MatchReveal> with TickerProviderStateMixin {
  late AnimationController _burstController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _burstController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _burstController.forward();
    _scaleController.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _burstController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_burstController, _scaleController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Neon burst rings
            ...List.generate(3, (index) {
              final delay = index * 0.15;
              final progress = (_burstController.value - delay).clamp(0.0, 1.0);
              
              return Container(
                width: 200 + (progress * 300),
                height: 200 + (progress * 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: V3Colors.primary.withOpacity((1 - progress) * 0.8),
                    width: 3,
                  ),
                  boxShadow: V3Colors.neonGlow(
                    V3Colors.primary,
                    intensity: (1 - progress) * 2,
                  ),
                ),
              );
            }),
            // Main content
            Transform.scale(
              scale: Curves.elasticOut.transform(_scaleController.value),
              child: widget.child,
            ),
          ],
        );
      },
    );
  }
}

