import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V7 High Contrast Red - Swipe Flow - Harsh snap animation
class V7SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V7SwipeCard({super.key, required this.child, required this.onSwipeLeft, required this.onSwipeRight, this.onSwipeUp});

  @override
  State<V7SwipeCard> createState() => _V7SwipeCardState();
}

class _V7SwipeCardState extends State<V7SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150)); // Fast snap
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotation = _position.dx * 0.001;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    
    if (progress > 0.25) {
      _snapOut(true);
    } else if (progress < -0.25) {
      _snapOut(false);
    } else {
      _snapBack();
    }
  }

  void _snapBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    void listener() => setState(() { _position = posAnim.value; _rotation = rotAnim.value; });
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _snapOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    
    final posAnim = Tween<Offset>(begin: _position, end: Offset(targetX, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    void listener() => setState(() => _position = posAnim.value);
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.3)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()..translate(_position.dx, _position.dy)..rotateZ(_rotation),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(boxShadow: V7Colors.sharpShadow),
          child: Stack(
            children: [
              widget.child,
              if (_swipeProgress > 0)
                Positioned.fill(
                  child: Container(
                    color: V7Colors.likeColor.withOpacity(_swipeProgress * 0.3),
                    child: Center(
                      child: Opacity(
                        opacity: _swipeProgress,
                        child: Transform.rotate(
                          angle: -math.pi / 12,
                          child: Text('LIKE', style: V7Fonts.displayLarge.copyWith(color: V7Colors.likeColor)),
                        ),
                      ),
                    ),
                  ),
                ),
              if (_swipeProgress < 0)
                Positioned.fill(
                  child: Container(
                    color: V7Colors.passColor.withOpacity(-_swipeProgress * 0.3),
                    child: Center(
                      child: Opacity(
                        opacity: -_swipeProgress,
                        child: Transform.rotate(
                          angle: math.pi / 12,
                          child: Text('NOPE', style: V7Fonts.displayLarge.copyWith(color: V7Colors.passColor)),
                        ),
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

class V7CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V7CardStack({super.key, required this.cards, this.visibleCards = 2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        math.min(visibleCards, cards.length),
        (index) {
          final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
          return Positioned.fill(
            child: Transform.translate(
              offset: Offset(reverseIndex * 8.0, reverseIndex * 8.0),
              child: cards[index],
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

