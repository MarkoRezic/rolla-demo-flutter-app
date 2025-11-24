// Reference image (uploaded by user): /mnt/data/rolla score card.PNG
// ScoreCard widget implementation

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/presentation/widgets/rounded_linear_progress_indicator.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class ScoreCardLinearProgressIndicator extends StatelessWidget {
  final double value;

  const ScoreCardLinearProgressIndicator({Key? key, required this.value})
    : super(key: key);

  static const double height = 8;

  Color get _colorForPercent {
    // thresholds: 0-50% neutral, 51-79% blue, 80+% green
    if (value <= 0.5) {
      return AppColors.grey; // neutral
    } else if (value <= 0.79) {
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
      color: _colorForPercent,
      backgroundColor: Theme.of(
        context,
      ).colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}
