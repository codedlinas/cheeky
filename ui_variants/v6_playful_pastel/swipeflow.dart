import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V6 Playful Pastel - Swipe Flow
/// Playful exaggerated bounce + pastel gradients
class V6SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V6SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V6SwipeCard> createState() => _V6SwipeCardState();
}

class _V6SwipeCardState extends State<V6SwipeCard> with TickerProviderStateMixin {
  late AnimationController _dragController;
  late AnimationController _wobbleController;
  
  Offset _position = Offset.zero;
  double _rotation = 0;
  double _wobble = 0;
  
  static const double _rotationFactor = 0.002;
  static const double _swipeThreshold = 0.3;

  @override
  void initState() {
    super.initState();
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _dragController.dispose();
    _wobbleController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotation = _position.dx * _rotationFactor;
      // Add wobble effect
      _wobble = math.sin(_position.dx / 20) * 0.02;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    
    if (progress > _swipeThreshold) {
      _bouncyAnimateOut(true);
    } else if (progress < -_swipeThreshold) {
      _bouncyAnimateOut(false);
    } else {
      _bouncySnapBack();
    }
  }

  void _bouncySnapBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(
          parent: _dragController,
          curve: Curves.elasticOut,
        ));
    
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(
          parent: _dragController,
          curve: Curves.elasticOut,
        ));
    
    void listener() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
      _wobble = 0;
    });
    
    posAnim.addListener(listener);
    _dragController.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _bouncyAnimateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    
    final posAnim = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, _position.dy - 50),
    ).animate(CurvedAnimation(
      parent: _dragController,
      curve: Curves.easeOutBack,
    ));
    
    final rotAnim = Tween<double>(
      begin: _rotation,
      end: isRight ? 0.5 : -0.5,
    ).animate(CurvedAnimation(
      parent: _dragController,
      curve: Curves.easeOutBack,
    ));
    
    void listener() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    });
    
    posAnim.addListener(listener);
    _dragController.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.35)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_rotation + _wobble),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: V6Colors.softShadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                widget.child,
                
                // Playful LIKE overlay
                if (_swipeProgress > 0)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            V6Colors.accent.withOpacity(_swipeProgress * 0.4),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Transform.rotate(
                            angle: -math.pi / 12,
                            child: Transform.scale(
                              scale: 0.8 + (_swipeProgress * 0.3),
                              child: Opacity(
                                opacity: _swipeProgress,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: V6Colors.accent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text('LIKE! 💚', style: V6Fonts.headlineLarge.copyWith(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Playful NOPE overlay
                if (_swipeProgress < 0)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            V6Colors.coral.withOpacity(-_swipeProgress * 0.4),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Transform.rotate(
                            angle: math.pi / 12,
                            child: Transform.scale(
                              scale: 0.8 + (-_swipeProgress * 0.3),
                              child: Opacity(
                                opacity: -_swipeProgress,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: V6Colors.coral,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text('NOPE 👋', style: V6Fonts.headlineLarge.copyWith(color: Colors.white)),
                                ),
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
        ),
      ),
    );
  }
}

/// Playful card stack
class V6CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V6CardStack({
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
          // Playful offset
          final offset = reverseIndex * 12.0;
          final rotation = reverseIndex * 0.02;
          
          return Positioned.fill(
            child: Transform(
              transform: Matrix4.identity()
                ..translate(offset, offset)
                ..rotateZ(rotation)
                ..scale(1.0 - (reverseIndex * 0.04)),
              alignment: Alignment.center,
              child: cards[index],
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

