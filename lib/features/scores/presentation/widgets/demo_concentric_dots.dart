import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/concentric_dots_background.dart';

class DemoConcentricDots extends StatefulWidget {
  @override
  _DemoConcentricDotsState createState() => _DemoConcentricDotsState();
}

class _DemoConcentricDotsState extends State<DemoConcentricDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        // rotation value in radians (full spin = 2π)
        final rotation = _ctrl.value * 2 * pi;
        return ConcentricDotsBackground(
          dotRadius: 3,
          ringSpacing: 40,
          dotSpacing: 28,
          baseColor: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.1),
          rotation: rotation,
          padding: const EdgeInsets.all(0),
        );
      },
    );
  }
}
