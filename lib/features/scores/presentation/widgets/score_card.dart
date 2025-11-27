// Reference image (uploaded by user): /mnt/data/rolla score card.PNG
// ScoreCard widget implementation

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/score_linear_progress_indicator.dart';
import 'package:shimmer/shimmer.dart';

class ScoreCard extends StatelessWidget {
  final Widget? icon;
  final String title;
  final double? value;
  final double? scoreValue;
  final String Function(double? value)? displayValue;
  final VoidCallback? onTap;
  final bool isLoading;

  const ScoreCard({
    Key? key,
    this.icon,
    required this.title,
    required this.value,
    this.scoreValue,
    this.displayValue,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  // Named constructor for shimmer state
  ScoreCard.loading({Key? key})
    : icon = null,
      title = '',
      value = null,
      scoreValue = null,
      displayValue = null,
      onTap = null,
      isLoading = true,
      super(key: key);

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

  String _maybeFormatValue(double? v) =>
      displayValue != null ? displayValue!(v) : _defaultDisplayValue(v);

  @override
  Widget build(BuildContext context) {
    final display = _maybeFormatValue(value);
    final hasProgress = scoreValue != null;
    final percent = hasProgress ? scoreValue!.clamp(0, 100) / 100 : null;
    final progressColor = hasProgress
        ? _colorForPercent(context, percent!)
        : Colors.transparent;

    final shimmerBaseColor = AppTheme.shimmerBase(context);
    final shimmerHighlightColor = AppTheme.shimmerHighlight(context);

    final titleWidget = isLoading
        ? Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              height: 16,
              width: 80,
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        : Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          );

    final valueWidget = isLoading
        ? Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              height: 20,
              width: 45,
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        : Text(
            display,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
          );

    final iconWidget = isLoading
        ? Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              width: AppIcon.defaultSize,
              height: AppIcon.defaultSize,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          )
        : icon;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.fromBorderSide(
              BorderSide(width: 1, color: AppTheme.lightGrey(context)),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (iconWidget != null) iconWidget,
                    if (iconWidget != null) const SizedBox(width: 12),
                    Expanded(child: titleWidget),
                    const SizedBox(width: 12),
                    valueWidget,
                  ],
                ),
              ),

              if (hasProgress)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -ScoreCardLinearProgressIndicator.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: ScoreCardLinearProgressIndicator(
                            value: percent!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
