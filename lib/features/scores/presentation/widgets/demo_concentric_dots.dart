import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/concentric_dots_background.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/radial_gauge.dart';

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
        return Stack(
          alignment: AlignmentGeometry.center,
          children: [
            ConcentricDotsBackground(
              baseColor: AppTheme.lightGrey(context),
              rotation: rotation,
            ),
            RadialGauge(value: 82, valueColor: AppColors.purple),
          ],
        );
      },
    );
  }
}
