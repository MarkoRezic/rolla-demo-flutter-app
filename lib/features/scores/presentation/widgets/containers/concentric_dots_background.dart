import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class ConcentricDotsBackground extends StatelessWidget {

  const ConcentricDotsBackground({
    super.key,
    this.dotRadius = 3,
    this.ringSpacing = 32,
    this.dotSpacing = 24,
    this.baseColor = AppColors.surfaceLight,
    this.rotation = 0.0,
    this.padding = EdgeInsets.zero,
  });
  final double dotRadius;
  final double ringSpacing;
  final double dotSpacing;
  final Color baseColor;
  final double rotation;
  final EdgeInsetsGeometry padding;

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

  _ConcentricDotsPainter({
    required this.dotRadius,
    required this.ringSpacing,
    required this.dotSpacing,
    required this.baseColor,
    required this.rotation,
  });
  final double dotRadius;
  final double ringSpacing;
  final double dotSpacing;
  final Color baseColor;
  final double rotation;

  final Paint _paint = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final Offset center = size.center(Offset.zero);
    final double maxRadius = sqrt(center.dx * center.dx + center.dy * center.dy);

    // Draw dots on a separate layer so blend overlay composes correctly
    final Rect layerRect = Offset.zero & size;
    canvas.saveLayer(layerRect, Paint());

    double r = max(dotRadius, ringSpacing * 0.5);
    while (r <= maxRadius + ringSpacing) {
      final double circumference = 2 * pi * max(0.0001, r);
      final int count = max(1, (circumference / dotSpacing).floor());
      _paint.color = baseColor;

      for (int i = 0; i < count; i++) {
        final double angle = rotation + (i * 2 * pi / count);
        final double dx = center.dx + r * cos(angle);
        final double dy = center.dy + r * sin(angle);
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
