import 'dart:ui';
import 'package:flutter/material.dart';

class AuroraEffect extends AnimatedWidget {
  final Animation<Alignment> topCircle;
  final Animation<Alignment> centerCircle;
  final Animation<Alignment> bottomCircle;
  final bool isLightTheme;

  AuroraEffect({
    required this.topCircle,
    required this.centerCircle,
    required this.bottomCircle,
    this.isLightTheme = false,
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
        isLightTheme: isLightTheme,
      ),
    );

    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: isLightTheme ? 30 : 50,
        sigmaY: isLightTheme ? 30 : 50,
      ),
      child: effect,
    );
  }
}

class AuroraPainter extends CustomPainter {
  final Alignment topCenter;
  final Alignment centerCenter;
  final Alignment bottomCenter;
  final bool isLightTheme;

  AuroraPainter({
    required this.topCenter,
    required this.centerCenter,
    required this.bottomCenter,
    this.isLightTheme = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);

    // Theme-aware colors
    final colors = isLightTheme
        ? [
            const Color(0xFF6366F1), // Indigo
            const Color(0xFF8B5CF6), // Violet
            const Color(0xFFEC4899), // Pink
          ]
        : [
            const Color(0xFF75152F), // Dark red
            const Color(0xFFCF1745), // Red
            const Color(0xFFFF2E62), // Pink
          ];

    final opacity = isLightTheme ? 0.15 : 0.4;
    final centerOpacity = isLightTheme ? 0.1 : 0.3;

    final paints = [
      Paint()
        ..shader = RadialGradient(
          center: topCenter,
          radius: 0.6,
          colors: [colors[0].withOpacity(opacity), colors[0].withOpacity(0)],
        ).createShader(bounds),
      Paint()
        ..shader = RadialGradient(
          center: centerCenter,
          radius: 0.4,
          colors: [
            colors[1].withOpacity(centerOpacity),
            colors[1].withOpacity(0),
          ],
        ).createShader(bounds),
      Paint()
        ..shader = RadialGradient(
          center: bottomCenter,
          radius: 0.6,
          colors: [colors[2].withOpacity(opacity), colors[2].withOpacity(0)],
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
        bottomCenter != oldDelegate.bottomCenter ||
        isLightTheme != oldDelegate.isLightTheme;
  }
}
