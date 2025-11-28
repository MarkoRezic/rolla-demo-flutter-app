import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score_activity.dart';
import 'package:rolla_demo_app/features/scores/presentation/utils/time_utils.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/card_container.dart';
import 'package:shimmer/shimmer.dart';

class ScoreActivityCard extends StatelessWidget {

  const ScoreActivityCard({
    super.key,
    this.icon,
    required this.title,
    this.category,
    this.duration,
    this.calories,
    this.backgroundColor,
    this.isLoading = false,
  });

  ScoreActivityCard.fromActivity({super.key, ScoreActivity? scoreActivity})
    : icon = null,
      title = tr.activityCategory(scoreActivity?.category ?? '???'),
      category = scoreActivity?.category,
      duration = scoreActivity == null
          ? null
          : Duration(seconds: scoreActivity.durationSeconds.round()),
      calories = scoreActivity?.calories,
      backgroundColor = null,
      isLoading = false;

  // Named constructor for shimmer state
  const ScoreActivityCard.loading({super.key})
    : icon = null,
      title = '',
      category = null,
      duration = null,
      calories = null,
      backgroundColor = null,
      isLoading = true;
  final Widget? icon;
  final String title;
  final String? category;
  final Duration? duration;
  final double? calories;
  final Color? backgroundColor;
  final bool isLoading;

  Widget _getDefaultIconForActivity(BuildContext context) {
    String iconPath = AppIconPaths.fire;
    switch (category) {
      case 'cardio':
      case 'cycling':
      case 'dance':
      case 'hiit':
      case 'hiking':
      case 'intervals':
      case 'pilates':
      case 'running':
      case 'strength training':
      case 'swimming':
      case 'walking':
      case 'yoga':
        iconPath = AppIconPaths.getPath(category!.replaceAll(" ", "_"));
        break;
      default:
        break;
    }

    return AppIcon(iconPath, color: Theme.of(context).scaffoldBackgroundColor);
  }

  String _formatDuration() {
    if (duration == null) return tr.noData;
    return formatDuration(duration!);
  }

  String _formatCalories() {
    if (calories == null) return '';
    return '${tr.calories}: ${calories!.round()} ${tr.valueUnitKcal}';
  }

  @override
  Widget build(BuildContext context) {
    final String displayValue = _formatDuration();
    final String displayCalories = _formatCalories();

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

    final double iconContainerSize = 48;
    final Widget iconWidget = isLoading
        ? Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          )
        : Container(
            width: iconContainerSize,
            height: iconContainerSize,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: icon ?? _getDefaultIconForActivity(context),
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
            displayValue,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );

    final Widget caloriesWidget = isLoading
        ? Shimmer.fromColors(
            baseColor: shimmerBaseColor,
            highlightColor: shimmerHighlightColor,
            child: Container(
              height: 16,
              width: 30,
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        : Text(
            displayCalories,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          );

    return CardContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            iconWidget,
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[titleWidget, caloriesWidget],
            ),
            const SizedBox(width: 12),
            const Spacer(),
            valueWidget,
          ],
        ),
      ),
    );
  }
}
