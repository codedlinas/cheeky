import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V4 Minimal Soft - Swipe Flow
/// Flat card slide with NO rotation, straight movement
class V4SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V4SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V4SwipeCard> createState() => _V4SwipeCardState();
}

class _V4SwipeCardState extends State<V4SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  
  // Minimal - no rotation
  static const double _swipeThreshold = 0.3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
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
      _animateBack();
    }
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.2 : -screenWidth * 1.2;
    
    final animation = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, 0), // Straight horizontal
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    void listener() => setState(() => _position = animation.value);
    animation.addListener(listener);
    
    _controller.forward(from: 0).then((_) {
      animation.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  void _animateBack() {
    final animation = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    void listener() => setState(() => _position = animation.value);
    animation.addListener(listener);
    
    _controller.forward(from: 0).then((_) => animation.removeListener(listener));
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.4)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _position,
        child: Opacity(
          opacity: 1.0 - (_swipeProgress.abs() * 0.3),
          child: Stack(
            children: [
              widget.child,
              
              // Minimal like indicator
              if (_swipeProgress > 0)
                Positioned(
                  left: 20,
                  top: 20,
                  child: Opacity(
                    opacity: _swipeProgress,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: V4Colors.likeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'LIKE',
                        style: V4Fonts.labelLarge.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              
              // Minimal nope indicator
              if (_swipeProgress < 0)
                Positioned(
                  right: 20,
                  top: 20,
                  child: Opacity(
                    opacity: -_swipeProgress,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: V4Colors.passColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'NOPE',
                        style: V4Fonts.labelLarge.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple card stack - minimal depth
class V4CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V4CardStack({
    super.key,
    required this.cards,
    this.visibleCards = 2, // Less cards visible for minimal look
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        math.min(visibleCards, cards.length),
        (index) {
          final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
          
          return Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, reverseIndex * 6.0),
              child: Transform.scale(
                scale: 1.0 - (reverseIndex * 0.02),
                child: Opacity(
                  opacity: 1.0 - (reverseIndex * 0.15),
                  child: cards[index],
                ),
              ),
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

