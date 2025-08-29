import 'dart:ui';
import 'package:flutter/material.dart';

class AuroraEffect extends AnimatedWidget {
  final Animation<Alignment> topCircle;
  final Animation<Alignment> centerCircle;
  final Animation<Alignment> bottomCircle;

  AuroraEffect({
    required this.topCircle,
    required this.centerCircle,
    required this.bottomCircle,
  }) : super(
         listenable: Listenable.merge([topCircle, centerCircle, bottomCircle]),
       );

  @override
  Widget build(BuildContext context) {
    Widget effect = CustomPaint(
      size: Size.infinite,
      painter: AuroraPainter(
        topCenter: topCircle.value,
        centerCenter: centerCircle.value,
        bottomCenter: bottomCircle.value,
      ),
    );

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: effect,
    );
  }
}

class AuroraPainter extends CustomPainter {
  final Alignment topCenter;
  final Alignment centerCenter;
  final Alignment bottomCenter;

  AuroraPainter({
    required this.topCenter,
    required this.centerCenter,
    required this.bottomCenter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);

    const colors = [Color(0xFF75152F), Color(0xFFCF1745), Color(0xFFFF2E62)];

    final paints = [
      Paint()
        ..shader = RadialGradient(
          center: topCenter,
          radius: 0.6,
          colors: [colors[0].withOpacity(0.4), colors[0].withOpacity(0)],
        ).createShader(bounds),
      Paint()
        ..shader = RadialGradient(
          center: centerCenter,
          radius: 0.4,
          colors: [colors[1].withOpacity(0.3), colors[1].withOpacity(0)],
        ).createShader(bounds),
      Paint()
        ..shader = RadialGradient(
          center: bottomCenter,
          radius: 0.6,
          colors: [colors[2].withOpacity(0.4), colors[2].withOpacity(0)],
        ).createShader(bounds),
    ];

    canvas.saveLayer(bounds, Paint());
    for (final paint in paints) {
      canvas.drawRect(bounds, paint..blendMode = BlendMode.multiply);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AuroraPainter oldDelegate) {
    return topCenter != oldDelegate.topCenter ||
        centerCenter != oldDelegate.centerCenter ||
        bottomCenter != oldDelegate.bottomCenter;
  }
}
