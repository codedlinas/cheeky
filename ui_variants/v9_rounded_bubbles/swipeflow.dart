import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

class V9SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;
  const V9SwipeCard({super.key, required this.child, required this.onSwipeLeft, required this.onSwipeRight, this.onSwipeUp});
  @override
  State<V9SwipeCard> createState() => _V9SwipeCardState();
}

class _V9SwipeCardState extends State<V9SwipeCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _springController;
  Offset _position = Offset.zero;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _springController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() { _controller.dispose(); _springController.dispose(); super.dispose(); }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() { _position += details.delta; _rotation = _position.dx * 0.0015; });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    if (progress > 0.28) { _springOut(true); }
    else if (progress < -0.28) { _springOut(false); }
    else { _springBack(); }
  }

  void _springBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero).animate(CurvedAnimation(parent: _springController, curve: Curves.elasticOut));
    final rotAnim = Tween<double>(begin: _rotation, end: 0).animate(CurvedAnimation(parent: _springController, curve: Curves.elasticOut));
    void listener() => setState(() { _position = posAnim.value; _rotation = rotAnim.value; });
    posAnim.addListener(listener);
    _springController.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _springOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.4 : -screenWidth * 1.4;
    final posAnim = Tween<Offset>(begin: _position, end: Offset(targetX, _position.dy - 30)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), boxShadow: V9Colors.bubbleShadow),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(children: [
              widget.child,
              if (_swipeProgress > 0) Positioned(left: 24, top: 24, child: Transform.scale(scale: 0.8 + _swipeProgress * 0.3, child: Opacity(opacity: _swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: V9Colors.likeColor, borderRadius: BorderRadius.circular(50)), child: Text('LIKE ❤️', style: V9Fonts.labelLarge.copyWith(color: Colors.white)))))),
              if (_swipeProgress < 0) Positioned(right: 24, top: 24, child: Transform.scale(scale: 0.8 + (-_swipeProgress) * 0.3, child: Opacity(opacity: -_swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: V9Colors.passColor, borderRadius: BorderRadius.circular(50)), child: Text('NOPE 👋', style: V9Fonts.labelLarge.copyWith(color: Colors.white)))))),
            ]),
          ),
        ),
      ),
    );
  }
}

class V9CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;
  const V9CardStack({super.key, required this.cards, this.visibleCards = 3});
  @override
  Widget build(BuildContext context) => Stack(children: List.generate(math.min(visibleCards, cards.length), (index) {
    final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
    return Positioned.fill(child: Transform(transform: Matrix4.identity()..translate(0.0, reverseIndex * 10.0)..scale(1.0 - (reverseIndex * 0.04)), alignment: Alignment.center, child: Opacity(opacity: 1.0 - (reverseIndex * 0.2), child: cards[index])));
  }).reversed.toList());
}

