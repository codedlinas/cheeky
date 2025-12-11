import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V1 Classic Tinder - Swipe Flow
/// Classic card stack with slide left/right and subtle tilt
class V1SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V1SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V1SwipeCard> createState() => _V1SwipeCardState();
}

class _V1SwipeCardState extends State<V1SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  double _rotation = 0;
  
  // Classic Tinder constants
  static const double _rotationFactor = 0.0015;
  static const double _swipeThreshold = 0.4;
  static const Duration _snapDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _snapDuration);
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
      _animateBack();
    }
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    
    final posAnim = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, _position.dy + 100),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    final rotAnim = Tween<double>(
      begin: _rotation,
      end: isRight ? 0.3 : -0.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    posAnim.addListener(() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    }));
    
    _controller.forward(from: 0).then((_) {
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  void _animateBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    
    posAnim.addListener(() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    }));
    
    _controller.forward(from: 0);
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.5)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_rotation),
        alignment: Alignment.center,
        child: Stack(
          children: [
            widget.child,
            // LIKE overlay
            if (_swipeProgress > 0)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: V1Colors.likeColor.withOpacity(_swipeProgress),
                      width: 4,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Transform.rotate(
                        angle: -math.pi / 12,
                        child: Opacity(
                          opacity: _swipeProgress,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: V1Colors.likeColor, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('LIKE', style: V1Fonts.headlineLarge.copyWith(color: V1Colors.likeColor)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // NOPE overlay
            if (_swipeProgress < 0)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: V1Colors.passColor.withOpacity(-_swipeProgress),
                      width: 4,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Transform.rotate(
                        angle: math.pi / 12,
                        child: Opacity(
                          opacity: -_swipeProgress,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: V1Colors.passColor, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('NOPE', style: V1Fonts.headlineLarge.copyWith(color: V1Colors.passColor)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Card stack with depth effect
class V1CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V1CardStack({
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
                ..translate(0.0, reverseIndex * 8.0)
                ..scale(1.0 - (reverseIndex * 0.05)),
              alignment: Alignment.center,
              child: cards[index],
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

