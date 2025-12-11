import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V5 Luxury Gold Black - Swipe Flow
/// Premium slow-easing swipe with gold highlight
class V5SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V5SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V5SwipeCard> createState() => _V5SwipeCardState();
}

class _V5SwipeCardState extends State<V5SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  double _rotation = 0;
  
  // Luxury - slow and elegant
  static const double _rotationFactor = 0.0008;
  static const double _swipeThreshold = 0.35;
  static const Duration _animDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotation = _position.dx * _rotationFactor;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    
    if (progress > _swipeThreshold) {
      _animateOut(true);
    } else if (progress < -_swipeThreshold) {
      _animateOut(false);
    } else {
      _elegantSnapBack();
    }
  }

  void _elegantSnapBack() {
    // Slow, elegant snap back
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutQuart,
        ));
    
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutQuart,
        ));
    
    void listener() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    });
    
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.3 : -screenWidth * 1.3;
    
    // Slow, premium exit
    final posAnim = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, _position.dy + 30),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));
    
    final rotAnim = Tween<double>(
      begin: _rotation,
      end: isRight ? 0.15 : -0.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));
    
    void listener() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    });
    
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.4)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final goldOpacity = _swipeProgress.abs() * 0.6;
    
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_rotation),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: V5Colors.gold.withOpacity(goldOpacity),
              width: 2,
            ),
            boxShadow: [
              ...V5Colors.luxuryShadow,
              if (goldOpacity > 0)
                BoxShadow(
                  color: V5Colors.gold.withOpacity(goldOpacity * 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                widget.child,
                
                // Gold highlight overlay on interaction
                if (_swipeProgress.abs() > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              V5Colors.gold.withOpacity(goldOpacity * 0.1),
                              Colors.transparent,
                            ],
                            begin: _swipeProgress > 0
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            end: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Elegant LIKE indicator
                if (_swipeProgress > 0.1)
                  Positioned(
                    left: 30,
                    top: 30,
                    child: Transform.rotate(
                      angle: -math.pi / 12,
                      child: Opacity(
                        opacity: _swipeProgress,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: V5Colors.gold, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('LIKE', style: V5Fonts.goldText(fontSize: 24)),
                        ),
                      ),
                    ),
                  ),
                
                // Elegant NOPE indicator
                if (_swipeProgress < -0.1)
                  Positioned(
                    right: 30,
                    top: 30,
                    child: Transform.rotate(
                      angle: math.pi / 12,
                      child: Opacity(
                        opacity: -_swipeProgress,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: V5Colors.passColor, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NOPE',
                            style: V5Fonts.headlineLarge.copyWith(color: V5Colors.passColor),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Luxury card stack
class V5CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V5CardStack({
    super.key,
    required this.cards,
    this.visibleCards = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        math.min(visibleCards, cards.length),
        (index) {
          final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
          
          return Positioned.fill(
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, reverseIndex * 10.0)
                ..scale(1.0 - (reverseIndex * 0.04)),
              alignment: Alignment.center,
              child: Opacity(
                opacity: 1.0 - (reverseIndex * 0.25),
                child: cards[index],
              ),
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

