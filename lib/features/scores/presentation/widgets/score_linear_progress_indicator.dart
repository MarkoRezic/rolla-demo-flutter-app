// Reference image (uploaded by user): /mnt/data/rolla score card.PNG
// ScoreCard widget implementation

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/presentation/widgets/rounded_linear_progress_indicator.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';

class ScoreLinearProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final Color Function(double percent)? progressColor;
  final Color? backgroundColor;

  const ScoreLinearProgressIndicator({
    Key? key,
    required this.value,
    this.height = defaultHeight,
    this.progressColor,
    this.backgroundColor,
  }) : super(key: key);

  static const double defaultHeight = 8;

  Color get _colorForPercent {
    // thresholds: 0-50% neutral, 51-79% blue, 80+% green
    if (value <= 0.5) {
      return AppColors.grey; // neutral
    } else if (value < 0.8) {
      return AppColors.lightBlue; // blue
    } else {
      return AppColors.green; // green
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedLinearProgressIndicator(
      value: value,
      height: height,
      color: progressColor?.call(value) ?? _colorForPercent,
      backgroundColor: backgroundColor ?? AppTheme.lightGrey(context),
    );
  }
}
