import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V3 Dark Neon - Swipe Flow
/// Dark cards with neon border glow, pulse animations
class V3SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V3SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V3SwipeCard> createState() => _V3SwipeCardState();
}

class _V3SwipeCardState extends State<V3SwipeCard> with TickerProviderStateMixin {
  late AnimationController _dragController;
  late AnimationController _pulseController;
  
  Offset _position = Offset.zero;
  double _rotation = 0;
  
  static const double _rotationFactor = 0.0012;
  static const double _swipeThreshold = 0.35;

  @override
  void initState() {
    super.initState();
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _dragController.dispose();
    _pulseController.dispose();
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
      _snapBack();
    }
  }

  void _snapBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(
          parent: _dragController,
          curve: Curves.easeOutBack,
        ));
    
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(
          parent: _dragController,
          curve: Curves.easeOutBack,
        ));
    
    void listener() => setState(() {
      _position = posAnim.value;
      _rotation = rotAnim.value;
    });
    
    posAnim.addListener(listener);
    _dragController.forward(from: 0).then((_) => posAnim.removeListener(listener));
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    
    final posAnim = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, _position.dy + 50),
    ).animate(CurvedAnimation(
      parent: _dragController,
      curve: Curves.easeOutQuart,
    ));
    
    void listener() => setState(() => _position = posAnim.value);
    posAnim.addListener(listener);
    
    _dragController.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.4)).clamp(-1.0, 1.0);

  Color get _glowColor {
    if (_swipeProgress > 0.1) return V3Colors.likeColor;
    if (_swipeProgress < -0.1) return V3Colors.passColor;
    return V3Colors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final pulseValue = 0.5 + (_pulseController.value * 0.5);
          
          return Transform(
            transform: Matrix4.identity()
              ..translate(_position.dx, _position.dy)
              ..rotateZ(_rotation),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: V3Colors.neonGlow(
                  _glowColor,
                  intensity: pulseValue * (1 + _swipeProgress.abs() * 0.5),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    widget.child,
                    
                    // Neon border
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _glowColor.withOpacity(0.8),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    
                    // LIKE overlay
                    if (_swipeProgress > 0)
                      _buildNeonOverlay('LIKE', V3Colors.likeColor, _swipeProgress, true),
                    
                    // NOPE overlay
                    if (_swipeProgress < 0)
                      _buildNeonOverlay('NOPE', V3Colors.passColor, -_swipeProgress, false),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNeonOverlay(String text, Color color, double opacity, bool isLeft) {
    return Positioned.fill(
      child: Align(
        alignment: isLeft ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Transform.rotate(
            angle: isLeft ? -math.pi / 12 : math.pi / 12,
            child: Opacity(
              opacity: opacity,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 3),
                  borderRadius: BorderRadius.circular(4),
                  color: color.withOpacity(0.2),
                  boxShadow: V3Colors.neonGlow(color, intensity: opacity),
                ),
                child: Text(
                  text,
                  style: V3Fonts.neonText(color, fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Neon card stack
class V3CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V3CardStack({
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
                ..scale(1.0 - (reverseIndex * 0.05)),
              alignment: Alignment.center,
              child: Opacity(
                opacity: 1.0 - (reverseIndex * 0.3),
                child: cards[index],
              ),
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

