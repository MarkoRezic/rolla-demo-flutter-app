import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/card_container.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_linear_progress_indicator.dart';
import 'package:shimmer/shimmer.dart';

class ScoreCard extends StatelessWidget {

  const ScoreCard({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    this.scoreValue,
    this.displayValue,
    this.onTap,
    this.isLoading = false,
  });

  // Named constructor for shimmer state
  const ScoreCard.loading({super.key})
    : icon = null,
      title = '',
      value = null,
      scoreValue = null,
      displayValue = null,
      onTap = null,
      isLoading = true;
  final Widget? icon;
  final String title;
  final double? value;
  final double? scoreValue;
  final String Function(double? value)? displayValue;
  final VoidCallback? onTap;
  final bool isLoading;

  String _defaultDisplayValue(double? v) {
    if (v == null) return tr.noData;
    return v.toStringAsFixed(0);
  }

  String _maybeFormatValue(double? v) => v == null
      ? tr.noData
      : displayValue != null
      ? displayValue!(v)
      : _defaultDisplayValue(v);

  @override
  Widget build(BuildContext context) {
    final String display = _maybeFormatValue(value);
    final bool hasProgress = scoreValue != null;
    final double? percent = hasProgress ? scoreValue!.clamp(0, 100) / 100 : null;

    final Color shimmerBaseColor = AppTheme.shimmerBase(context);
    final Color shimmerHighlightColor = AppTheme.shimmerHighlight(context);

    final Widget titleWidget = isLoading
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

    final Widget valueWidget = isLoading
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

    final Widget? iconWidget = isLoading
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

    return CardContainer(
      disabled: value == null,
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: <Widget>[
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
              bottom: -ScoreLinearProgressIndicator.defaultHeight / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ScoreLinearProgressIndicator(value: percent!),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
