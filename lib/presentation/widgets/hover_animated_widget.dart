import 'dart:math';
import 'package:flutter/material.dart';

class HoverAnimatedWidget extends StatefulWidget {
  final Widget child;

  const HoverAnimatedWidget({Key? key, required this.child}) : super(key: key);

  @override
  HoverAnimatedWidgetState createState() => HoverAnimatedWidgetState();
}

class HoverAnimatedWidgetState extends State<HoverAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward();
  }

  void _resetAnimation() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _startAnimation(),
      onExit: (_) => _resetAnimation(),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _rotateAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: widget.child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
