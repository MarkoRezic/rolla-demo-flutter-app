import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/disabled_wrapper.dart';
import 'package:shimmer/shimmer.dart';

class ScoreInfoCard extends StatelessWidget {
  final Widget? icon;
  final String title;
  final double? value;
  final double? scoreValue;
  final String Function(double? value)? displayValue;
  final Color? backgroundColor;
  final bool isLoading;

  const ScoreInfoCard({
    Key? key,
    this.icon,
    required this.title,
    required this.value,
    this.scoreValue,
    this.displayValue,
    this.backgroundColor,
    this.isLoading = false,
  }) : super(key: key);

  // Named constructor for shimmer state
  ScoreInfoCard.loading({Key? key})
    : icon = null,
      title = '',
      value = null,
      scoreValue = null,
      displayValue = null,
      backgroundColor = null,
      isLoading = true,
      super(key: key);

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
    final display = _maybeFormatValue(value);

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
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                display,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(width: 10),
              AppIcon(AppIconPaths.star),
              Container(
                alignment: Alignment.centerRight,
                width: 32,
                child: Text(
                  (scoreValue?.round() ?? 0).toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
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

    return DisabledWrapper(
      disabled: value == null,
      child: Material(
        color: Colors.transparent,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color:
                backgroundColor ??
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleWidget,
                const SizedBox(width: 12),
                if (iconWidget != null) iconWidget,
                if (iconWidget != null) const SizedBox(width: 12),
                const Spacer(),
                valueWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
