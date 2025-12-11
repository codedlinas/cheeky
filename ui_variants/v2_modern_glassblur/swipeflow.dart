import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'colors.dart';
import 'fonts.dart';

/// V2 Modern Glassblur - Swipe Flow
/// Glassmorphism with blur and elastic animations
class V2SwipeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback? onSwipeUp;

  const V2SwipeCard({
    super.key,
    required this.child,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onSwipeUp,
  });

  @override
  State<V2SwipeCard> createState() => _V2SwipeCardState();
}

class _V2SwipeCardState extends State<V2SwipeCard> with TickerProviderStateMixin {
  late AnimationController _dragController;
  late AnimationController _bounceController;
  
  Offset _position = Offset.zero;
  double _rotation = 0;
  double _scale = 1.0;
  
  // Elastic animation constants
  static const double _rotationFactor = 0.001;
  static const double _swipeThreshold = 0.35;

  @override
  void initState() {
    super.initState();
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _dragController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _bounceController.stop();
    setState(() => _scale = 1.02);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
      _rotation = _position.dx * _rotationFactor;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => _scale = 1.0);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final progress = _position.dx / screenWidth;
    
    if (progress > _swipeThreshold) {
      _animateOut(true);
    } else if (progress < -_swipeThreshold) {
      _animateOut(false);
    } else {
      _elasticSnapBack();
    }
  }

  void _elasticSnapBack() {
    final posAnim = Tween<Offset>(begin: _position, end: Offset.zero)
        .animate(CurvedAnimation(
          parent: _bounceController,
          curve: Curves.elasticOut,
        ));
    
    final rotAnim = Tween<double>(begin: _rotation, end: 0)
        .animate(CurvedAnimation(
          parent: _bounceController,
          curve: Curves.elasticOut,
        ));
    
    void listener() {
      setState(() {
        _position = posAnim.value;
        _rotation = rotAnim.value;
      });
    }
    
    posAnim.addListener(listener);
    _bounceController.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
    });
  }

  void _animateOut(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isRight ? screenWidth * 1.5 : -screenWidth * 1.5;
    
    final posAnim = Tween<Offset>(
      begin: _position,
      end: Offset(targetX, _position.dy * 0.5),
    ).animate(CurvedAnimation(
      parent: _dragController,
      curve: Curves.easeOutCubic,
    ));
    
    final scaleAnim = Tween<double>(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(
          parent: _dragController,
          curve: Curves.easeOut,
        ));
    
    void listener() {
      setState(() {
        _position = posAnim.value;
        _scale = scaleAnim.value;
      });
    }
    
    posAnim.addListener(listener);
    _dragController.forward(from: 0).then((_) {
      posAnim.removeListener(listener);
      isRight ? widget.onSwipeRight() : widget.onSwipeLeft();
    });
  }

  double get _swipeProgress => (_position.dx / (MediaQuery.of(context).size.width * 0.4)).clamp(-1.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..rotateZ(_rotation)
          ..scale(_scale),
        alignment: Alignment.center,
        child: Stack(
          children: [
            // Glass card container
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: widget.child,
              ),
            ),
            
            // Like glow overlay
            if (_swipeProgress > 0)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: V2Colors.likeColor.withOpacity(_swipeProgress * 0.8),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: V2Colors.likeColor.withOpacity(_swipeProgress * 0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: _buildOverlayText('LIKE', V2Colors.likeColor, _swipeProgress),
                ),
              ),
            
            // Nope glow overlay
            if (_swipeProgress < 0)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: V2Colors.passColor.withOpacity(-_swipeProgress * 0.8),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: V2Colors.passColor.withOpacity(-_swipeProgress * 0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: _buildOverlayText('NOPE', V2Colors.passColor, -_swipeProgress),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayText(String text, Color color, double opacity) {
    return Align(
      alignment: text == 'LIKE' ? Alignment.topLeft : Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Transform.rotate(
          angle: text == 'LIKE' ? -math.pi / 12 : math.pi / 12,
          child: Opacity(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 3),
                borderRadius: BorderRadius.circular(8),
                color: color.withOpacity(0.2),
              ),
              child: Text(
                text,
                style: V2Fonts.headlineLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glass card stack with depth blur
class V2CardStack extends StatelessWidget {
  final List<Widget> cards;
  final int visibleCards;

  const V2CardStack({
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
          final blur = reverseIndex * 2.0;
          
          return Positioned.fill(
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, reverseIndex * 12.0)
                ..scale(1.0 - (reverseIndex * 0.04)),
              alignment: Alignment.center,
              child: reverseIndex > 0
                  ? ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                      child: Opacity(
                        opacity: 1.0 - (reverseIndex * 0.2),
                        child: cards[index],
                      ),
                    )
                  : cards[index],
            ),
          );
        },
      ).reversed.toList(),
    );
  }
}

