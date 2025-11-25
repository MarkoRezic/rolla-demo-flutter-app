import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class ConcentricDotsBackground extends StatelessWidget {
  final double dotRadius;
  final double ringSpacing;
  final double dotSpacing;
  final Color baseColor;
  final double rotation;
  final EdgeInsetsGeometry padding;

  const ConcentricDotsBackground({
    Key? key,
    this.dotRadius = 3,
    this.ringSpacing = 32,
    this.dotSpacing = 24,
    this.baseColor = AppColors.surfaceLight,
    this.rotation = 0.0,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _ConcentricDotsPainter(
            dotRadius: dotRadius,
            ringSpacing: ringSpacing,
            dotSpacing: dotSpacing,
            baseColor: baseColor,
            rotation: rotation,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ConcentricDotsPainter extends CustomPainter {
  final double dotRadius;
  final double ringSpacing;
  final double dotSpacing;
  final Color baseColor;
  final double rotation;

  final Paint _paint = Paint()..isAntiAlias = true;

  _ConcentricDotsPainter({
    required this.dotRadius,
    required this.ringSpacing,
    required this.dotSpacing,
    required this.baseColor,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final center = size.center(Offset.zero);
    final maxRadius = sqrt(center.dx * center.dx + center.dy * center.dy);

    // Draw dots on a separate layer so blend overlay composes correctly
    final layerRect = Offset.zero & size;
    canvas.saveLayer(layerRect, Paint());

    double r = max(dotRadius, ringSpacing * 0.5);
    while (r <= maxRadius + ringSpacing) {
      final circumference = 2 * pi * max(0.0001, r);
      final count = max(1, (circumference / dotSpacing).floor());
      _paint.color = baseColor;

      for (int i = 0; i < count; i++) {
        final angle = rotation + (i * 2 * pi / count);
        final dx = center.dx + r * cos(angle);
        final dy = center.dy + r * sin(angle);
        canvas.drawCircle(Offset(dx, dy), dotRadius, _paint);
      }
      r += ringSpacing;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ConcentricDotsPainter old) {
    return old.dotRadius != dotRadius ||
        old.ringSpacing != ringSpacing ||
        old.dotSpacing != dotSpacing ||
        old.baseColor != baseColor ||
        old.rotation != rotation;
  }
}
