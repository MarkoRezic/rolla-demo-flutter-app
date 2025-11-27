import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/extensions/list/list_of_scores_average_metrics.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/date_time/date_time_timeframe_date_range.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/score/score_to_data_point_by_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';
import 'package:rolla_demo_app/features/scores/presentation/utils/time_utils.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/radial_gauge.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/score_card.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/timeframe_data_view.dart';

import '../bloc/score_bloc.dart';
import '../widgets/concentric_dots_stack_container.dart';

class ScoreDetailPage extends StatefulWidget {
  final ScoreType scoreType;
  const ScoreDetailPage({Key? key, required this.scoreType}) : super(key: key);

  @override
  State<ScoreDetailPage> createState() => _ScoreDetailPageState();
}

class _ScoreDetailPageState extends State<ScoreDetailPage> {
  late ScoreBloc bloc;
  DateTime selectedDate = DateTime.now();
  Timeframe selectedTimeframe = Timeframe.day;

  @override
  void initState() {
    super.initState();
    bloc = di.sl<ScoreBloc>();
    _loadScoresForCurrentTimeframe();
  }

  void _loadScoresForCurrentTimeframe() {
    DateTimeRange dateTimeRange = selectedDate.getDateRangeByTimeframe(
      selectedTimeframe,
    );
    Duration? mockLoadingTime;
    switch (selectedTimeframe) {
      case Timeframe.day:
        break;
      case Timeframe.week:
        break;
      case Timeframe.month:
        mockLoadingTime = Duration(milliseconds: 500);
        break;
      case Timeframe.year:
        mockLoadingTime = Duration(milliseconds: 2500);
        break;
    }
    bloc.add(
      LoadScoresEvent(
        from: dateTimeRange.start,
        to: dateTimeRange.end,
        mockLoadingTime: mockLoadingTime,
      ),
    );
  }

  void _onSelectedDateChange(DateTime date, Timeframe timeframe) {
    setState(() {
      selectedDate = date;
    });
    _loadScoresForCurrentTimeframe();
  }

  void _onSelectedTimeframeChange(Timeframe timeframe) {
    setState(() {
      selectedTimeframe = timeframe;
    });
    _loadScoresForCurrentTimeframe();
  }

  DateTime? _getMinDate(List<DataPoint>? dataPoints) {
    if (dataPoints == null || dataPoints.isEmpty) return null;
    List<DataPoint> sortedDataPoints = [...dataPoints];
    sortedDataPoints.sort((a, b) => a.date.isBefore(b.date) ? -1 : 1);
    return sortedDataPoints.first.date;
  }

  void _showScoreInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      isScrollControlled: true, // allows full height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: controller,
                children: const [
                  Text(
                    "Your Bottom Drawer",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Place your content here..."),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _separatedWidgets({
    required List<Widget> widgets,
    required Widget separator,
  }) {
    if (widgets.isEmpty) return [];

    final List<Widget> result = [];

    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i < widgets.length - 1) {
        result.add(separator);
      }
    }

    return result;
  }

  List<Widget> _buildMetricWidgets(ScoreState scoreState) {
    late List<Widget> widgets;

    if (scoreState is! ScoreLoaded) {
      int cardCount = 0;
      switch (widget.scoreType) {
        case ScoreType.activity:
          cardCount = 4;
          break;
        case ScoreType.readiness:
          cardCount = 3;
          break;
        case ScoreType.health:
          cardCount = 2;
          break;
      }
      widgets = List.generate(cardCount, (index) => ScoreCard.loading());
    } else {
      List<Score> scores = scoreState.scores;
      Score? averageScore = scores.averageScore;
      double _toDouble(num? number) => number?.toDouble() ?? 0;
      int _round(num? number) => number?.round() ?? 0;

      switch (widget.scoreType) {
        case ScoreType.activity:
          widgets = [
            ScoreCard(
              icon: AppIcon(AppIconPaths.star, color: AppColors.green),
              title: tr.activePoints,
              value: _toDouble(averageScore?.activePoints),
              scoreValue: _toDouble(averageScore?.activePointsScore),
              displayValue: (value) => '${_round(value)} pts',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.steps, color: AppColors.green),
              title: tr.steps,
              value: _toDouble(averageScore?.steps),
              scoreValue: _toDouble(averageScore?.stepsScore),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.timer, color: AppColors.lightBlue),
              title: tr.moveHours,
              value: _toDouble(averageScore?.moveHours),
              scoreValue: _toDouble(averageScore?.moveHoursScore),
              displayValue: (value) => '${_round(value)} h',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.fire, color: AppColors.orange),
              title: tr.activeCalories,
              value: _toDouble(averageScore?.activeCalories),
              displayValue: (value) => '${_round(value)} kcal',
            ),
          ];
          break;
        case ScoreType.readiness:
          widgets = [
            ScoreCard(
              icon: AppIcon(AppIconPaths.moon, color: AppColors.purple),
              title: tr.sleep,
              value: _toDouble(averageScore?.sleepMinutes),
              scoreValue: _toDouble(averageScore?.sleepScore),
              displayValue: (value) =>
                  formatMinutesHM(_round(averageScore?.sleepMinutes)),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.heartRate, color: AppColors.lightBlue),
              title: tr.restingHR,
              value: _toDouble(averageScore?.restingHeartRateBpm),
              scoreValue: _toDouble(averageScore?.restingHeartRateScore),
              displayValue: (value) => '${_round(value)} bpm',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.heartMonitor, color: AppColors.red),
              title: tr.overnightHRV,
              value: _toDouble(averageScore?.overnightHeartRateVarianceMs),
              scoreValue: _toDouble(
                averageScore?.overnightHeartRateVarianceScore,
              ),
              displayValue: (value) => '${_round(value)} ms',
            ),
          ];
          break;
        case ScoreType.health:
          widgets = [
            ScoreCard(
              icon: AppIcon(AppIconPaths.moon, color: AppColors.purple),
              title: tr.readiness,
              value: _toDouble(averageScore?.readinessScore),
              scoreValue: _toDouble(averageScore?.readinessScore),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.fire, color: AppColors.green),
              title: tr.activity,
              value: _toDouble(averageScore?.activityScore),
              scoreValue: _toDouble(averageScore?.activityScore),
            ),
          ];
          break;
      }
    }

    return _separatedWidgets(widgets: widgets, separator: SizedBox(height: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.scoreType.scoreTitle)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).brightness == Brightness.light
                  ? AppColors.surfaceLight
                  : Colors.black,
            ],
            stops: [0.5, 0.7],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async => _loadScoresForCurrentTimeframe(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                BlocBuilder<ScoreBloc, ScoreState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ScoreInitial) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ScoreLoading || state is ScoreLoaded) {
                      List<DataPoint>? dataPoints;
                      bool isLoading = state is ScoreLoading;

                      if (state is ScoreLoaded) {
                        dataPoints = state.scores
                            .map(
                              (score) =>
                                  score.toDataPointByType(widget.scoreType),
                            )
                            .toList();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 360,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TimeframeDataView(
                                    selectedDate: selectedDate,
                                    selectedTimeFrame: selectedTimeframe,
                                    onSelectedDateChange: _onSelectedDateChange,
                                    onSelectedTimeframeChange:
                                        _onSelectedTimeframeChange,
                                    minDate: _getMinDate(dataPoints),
                                    dataPoints: dataPoints,
                                    isLoading: isLoading,
                                    color: widget.scoreType.accentColor,
                                    gaugeBuilder: (context, value) => Container(
                                      height: 200,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ConcentricDotsStackContainer(
                                              children: [
                                                RadialGauge(
                                                  value: value.round(),
                                                  valueColor: widget
                                                      .scoreType
                                                      .accentColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    headerWidgetBuilder:
                                        (
                                          Timeframe timeframe,
                                        ) => timeframe != Timeframe.day
                                        ? Text(
                                            tr.history,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                widget.scoreType.scoreInfoTitle,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleLarge,
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    _showScoreInfo(context),
                                                iconSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withValues(alpha: 0.6),
                                                icon: Icon(Icons.help),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr.metrics,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (selectedTimeframe != Timeframe.day)
                                Text(
                                  tr.timeframeAvg(selectedTimeframe.name),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ..._buildMetricWidgets(state),
                          const SizedBox(height: 10),
                          Text(
                            tr.about,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.scoreType.scoreDescription,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      );
                    } else if (state is ScoreError) {
                      return Center(
                        child: Text('${tr.error}: ${state.message}'),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
