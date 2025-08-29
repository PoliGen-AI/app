import 'package:flutter/material.dart';
import 'aurora_painter.dart';

class AuroraBackground extends StatefulWidget {
  final Widget child;

  const AuroraBackground({super.key, required this.child});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Alignment> _topCircleAnimation;
  late final Animation<Alignment> _centerCircleAnimation;
  late final Animation<Alignment> _bottomCircleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _topCircleAnimation = AlignmentTween(
      begin: const Alignment(-0.8, -0.8),
      end: const Alignment(0.8, 0.8),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _centerCircleAnimation = AlignmentTween(
      begin: const Alignment(0.0, 0.0),
      end: const Alignment(0.2, -0.5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _bottomCircleAnimation = AlignmentTween(
      begin: const Alignment(0.8, 0.8),
      end: const Alignment(-0.8, -0.8),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF18181B);

    return Container(
      color: backgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AuroraEffect(
            topCircle: _topCircleAnimation,
            centerCircle: _centerCircleAnimation,
            bottomCircle: _bottomCircleAnimation,
          ),
          widget.child,
        ],
      ),
    );
  }
}
