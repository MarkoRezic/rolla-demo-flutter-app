import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/concentric_dots_background.dart';

class ConcentricDotsStackContainer extends StatefulWidget {
  const ConcentricDotsStackContainer({
    super.key,
    this.animationDuration = const Duration(seconds: 60),
    this.alignment = Alignment.center,
    this.dotRadius,
    this.ringSpacing,
    this.dotSpacing,
    this.baseColor,
    required this.children,
  });
  final Duration animationDuration;
  final AlignmentGeometry alignment;
  final double? dotRadius;
  final double? ringSpacing;
  final double? dotSpacing;
  final Color? baseColor;
  final List<Widget> children;

  @override
  State<ConcentricDotsStackContainer> createState() =>
      _ConcentricDotsStackContainerState();
}

class _ConcentricDotsStackContainerState
    extends State<ConcentricDotsStackContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.animationDuration)
      ..repeat();
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
      builder: (BuildContext context, Widget? child) {
        // rotation value in radians (full spin = 2π)
        final double rotation = _ctrl.value * 2 * pi;
        return Stack(
          alignment: widget.alignment,
          children: <Widget>[
            ConcentricDotsBackground(
              dotRadius: widget.dotRadius ?? 3,
              ringSpacing: widget.ringSpacing ?? 32,
              dotSpacing: widget.dotSpacing ?? 24,
              baseColor: widget.baseColor ?? AppTheme.lightGrey(context),
              rotation: rotation,
            ),
            ...widget.children,
          ],
        );
      },
    );
  }
}
