import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V10 - 3D Perspective Swipe with rotation on Z/Y axis
class V10SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;
  const V10SwipeCard({super.key, required this.child, required this.onSwipeLeft, required this.onSwipeRight, this.onSwipeUp});
  @override
  State<V10SwipeCard> createState() => _V10SwipeCardState();
}

class _V10SwipeCardState extends State<V10SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _position = Offset.zero;
  double _rotationZ = 0;
  double _rotationY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotationZ = _position.dx * 0.0008;
      _rotationY = _position.dx * 0.002; // 3D Y rotation
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    if (progress > 0.3) { _animate3dOut(true); }
    else if (progress < -0.3) { _animate3dOut(false); }
    else { _snapBack3d(); }
  }

  void _snapBack3d() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    final rotZAnim = Tween<double>(begin: _rotationZ, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    final rotYAnim = Tween<double>(begin: _rotationY, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    void listener() => setState(() { _position = posAnim.value; _rotationZ = rotZAnim.value; _rotationY = rotYAnim.value; });
    posAnim.addListener(listener);
    _controller.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _animate3dOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    final posAnim = Tween<Offset>(begin: _position, end: Offset(targetX, _position.dy)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    final rotYAnim = Tween<double>(begin: _rotationY, end: isRight ? math.pi / 4 : -math.pi / 4).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    void listener() => setState(() { _position = posAnim.value; _rotationY = rotYAnim.value; });
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
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspective
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_rotationZ)
          ..rotateY(_rotationY),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: V10Colors.depth3d),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              widget.child,
              if (_swipeProgress > 0) Positioned.fill(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [V10Colors.likeColor.withOpacity(_swipeProgress * 0.3), Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight)), child: Align(alignment: Alignment.topLeft, child: Padding(padding: const EdgeInsets.all(24), child: Opacity(opacity: _swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(border: Border.all(color: V10Colors.likeColor, width: 3), borderRadius: BorderRadius.circular(10)), child: Text('LIKE', style: V10Fonts.headlineLarge.copyWith(color: V10Colors.likeColor)))))))),
              if (_swipeProgress < 0) Positioned.fill(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Colors.transparent, V10Colors.passColor.withOpacity(-_swipeProgress * 0.3)], begin: Alignment.centerLeft, end: Alignment.centerRight)), child: Align(alignment: Alignment.topRight, child: Padding(padding: const EdgeInsets.all(24), child: Opacity(opacity: -_swipeProgress, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(border: Border.all(color: V10Colors.passColor, width: 3), borderRadius: BorderRadius.circular(10)), child: Text('NOPE', style: V10Fonts.headlineLarge.copyWith(color: V10Colors.passColor)))))))),
            ]),
          ),
        ),
      ),
    );
  }
}

/// 3D Parallax Card Stack
class V10CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;
  const V10CardStack({super.key, required this.cards, this.visibleCards = 3});

  @override
  Widget build(BuildContext context) => Stack(children: List.generate(math.min(visibleCards, cards.length), (index) {
    final reverseIndex = math.min(visibleCards, cards.length) - 1 - index;
    final zDepth = reverseIndex * 30.0;
    return Positioned.fill(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0.0, reverseIndex * 15.0, -zDepth)
          ..scale(1.0 - (reverseIndex * 0.06)),
        alignment: Alignment.center,
        child: Opacity(opacity: 1.0 - (reverseIndex * 0.25), child: cards[index]),
      ),
    );
  }).reversed.toList());
}

