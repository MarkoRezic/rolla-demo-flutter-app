import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';

class RoundedLinearProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  const RoundedLinearProgressIndicator({
    super.key,
    required this.value,
    this.height = 12,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.lightGrey(context),
        borderRadius: BorderRadius.circular(height),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(height),
          ),
        ),
      ),
    );
  }
}
