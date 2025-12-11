import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

class V8SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V8SwipeCard({super.key, required this.child, required this.onSwipeLeft, required this.onSwipeRight, this.onSwipeUp});

  @override
  State<V8SwipeCard> createState() => _V8SwipeCardState();
}

class _V8SwipeCardState extends State<V8SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() { _position += details.delta; _rotation = _position.dx * 0.001; });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    if (progress > 0.3) { _animateOut(true); } 
    else if (progress < -0.3) { _animateOut(false); } 
    else { _snapBack(); }
  }

  void _snapBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    final rotAnim = Tween<double>(begin: _rotation, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    void listener() => setState(() { _position = posAnim.value; _rotation = rotAnim.value; });
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.3 : -screenWidth * 1.3;
    final posAnim = Tween<Offset>(begin: _position, end: Offset(targetX, _position.dy)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    void listener() => setState(() => _position = posAnim.value);
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) { posAnim.removeListener(listener); isRight ? widget.onSwipeRight() : widget.onSwipeLeft(); });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.35)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()..translate(_position.dx, _position.dy)..rotateZ(_rotation),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: V8Colors.elevation4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                widget.child,
                if (_swipeProgress > 0) Positioned(left: 20, top: 20, child: Opacity(opacity: _swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: V8Colors.likeColor, borderRadius: BorderRadius.circular(4)), child: Text('LIKE', style: V8Fonts.labelLarge.copyWith(color: Colors.white))))),
                if (_swipeProgress < 0) Positioned(right: 20, top: 20, child: Opacity(opacity: -_swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: V8Colors.passColor, borderRadius: BorderRadius.circular(4)), child: Text('PASS', style: V8Fonts.labelLarge.copyWith(color: Colors.white))))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class V8CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;
  const V8CardStack({super.key, required this.cards, this.visibleCards = 2});

  @override
  Widget build(BuildContext context) {
    return Stack(children: List.generate(math.min(visibleCards, cards.length), (index) {
      final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
      return Positioned.fill(child: Transform(transform: Matrix4.identity()..translate(0.0, reverseIndex * 8.0)..scale(1.0 - (reverseIndex * 0.03)), alignment: Alignment.center, child: Opacity(opacity: 1.0 - (reverseIndex * 0.2), child: cards[index])));
    }).reversed.toList());
  }
}

