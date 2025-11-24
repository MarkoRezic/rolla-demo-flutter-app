// Reference image (uploaded by user): /mnt/data/rolla score card.PNG
// ScoreCard widget implementation

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class ScoreCard extends StatelessWidget {
  final Widget? icon;
  final String title;
  final double? value;
  final double? scoreValue;
  final String Function(double? value)? displayValue;
  final VoidCallback? onTap;

  const ScoreCard({
    Key? key,
    this.icon,
    required this.title,
    required this.value,
    this.scoreValue,
    this.displayValue,
    this.onTap,
  }) : super(key: key);

  String _defaultDisplayValue(double? v) {
    if (v == null) return 'No data';
    if (v.abs() >= 1000) return v.toStringAsFixed(0);
    if (v.abs() >= 100) return v.toStringAsFixed(0);
    if (v.abs() >= 10) return v.toStringAsFixed(1);
    return v.toStringAsFixed(2);
  }

  Color _colorForPercent(BuildContext context, double percent) {
    // thresholds: 0-50% neutral, 51-79% blue, 80+% green
    if (percent <= 0.5) {
      return AppColors.grey; // neutral
    } else if (percent <= 0.79) {
      return AppColors.blue; // blue
    } else {
      return AppColors.green; // green
    }
  }

  String _maybeFormatValue(double v) =>
      displayValue != null ? displayValue!(v) : _defaultDisplayValue(v);

  @override
  Widget build(BuildContext context) {
    final display = displayValue != null
        ? displayValue!(value)
        : _defaultDisplayValue(value);
    final hasProgress = scoreValue != null;
    final percent = hasProgress ? scoreValue!.clamp(0, 100) / 100 : null;
    final progressColor = hasProgress
        ? _colorForPercent(context, percent!)
        : Colors.transparent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: icon),
                    ),
                  if (icon != null) SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    display,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              if (hasProgress) SizedBox(height: 12),
              if (hasProgress)
                // progress bar
                LayoutBuilder(
                  builder: (context, constraints) {
                    final barHeight = 6.0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(barHeight / 2),
                          child: Container(
                            height: barHeight,
                            width: double.infinity,
                            color: Theme.of(
                              context,
                            ).dividerColor.withOpacity(0.45),
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: percent,
                                  child: Container(
                                    height: barHeight,
                                    color: progressColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
