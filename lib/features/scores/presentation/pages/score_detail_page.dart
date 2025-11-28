import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score_activity.dart';
import 'package:rolla_demo_app/features/scores/domain/extensions/list/list_first_where_or_null.dart';
import 'package:rolla_demo_app/features/scores/domain/extensions/list/list_of_scores_average_metrics.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/earliest_score_date_cubit.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/score_bloc.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/date_time/date_time_same_date_as.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/date_time/date_time_timeframe_date_range.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/score/score_to_data_point_by_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';
import 'package:rolla_demo_app/features/scores/presentation/utils/generate_contextual_insights.dart';
import 'package:rolla_demo_app/features/scores/presentation/utils/generate_short_contextual_insight.dart';
import 'package:rolla_demo_app/features/scores/presentation/utils/time_utils.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/concentric_dots_stack_container.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/radial_gauge.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_activity_card.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_card.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_info_card.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_insights_view.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/timeframe/timeframe_data_view.dart';

class ScoreDetailPage extends StatefulWidget {
  const ScoreDetailPage({
    super.key,
    required this.scoreType,
    this.initialSelectedDate,
    this.initialSelectedTimeframe,
    this.initialShowMonthlyAverages,
  });
  final ScoreType scoreType;
  final DateTime? initialSelectedDate;
  final Timeframe? initialSelectedTimeframe;
  final bool? initialShowMonthlyAverages;

  @override
  State<ScoreDetailPage> createState() => _ScoreDetailPageState();
}

class _ScoreDetailPageState extends State<ScoreDetailPage> {
  late ScoreBloc _scoreBloc;
  late EarliestScoreDateCubit _earliestScoreDateCubit;
  late DateTime _selectedDate = widget.initialSelectedDate ?? DateTime.now();
  late Timeframe _selectedTimeframe =
      widget.initialSelectedTimeframe ?? Timeframe.day;
  late bool _showMonthlyAverages = widget.initialShowMonthlyAverages ?? false;

  @override
  void initState() {
    super.initState();
    _scoreBloc = GetIt.instance<ScoreBloc>();
    _earliestScoreDateCubit = GetIt.instance<EarliestScoreDateCubit>();
    _loadScoresForCurrentTimeframe();
    _fetchEarliestScoreDate();
  }

  void _loadScoresForCurrentTimeframe() {
    final DateTimeRange dateTimeRange = _selectedDate.getDateRangeByTimeframe(
      _selectedTimeframe,
    );
    Duration? mockLoadingTime;
    switch (_selectedTimeframe) {
      case Timeframe.day:
        break;
      case Timeframe.week:
        break;
      case Timeframe.month:
        mockLoadingTime = const Duration(milliseconds: 500);
        break;
      case Timeframe.year:
        mockLoadingTime = const Duration(milliseconds: 2500);
        break;
    }
    _scoreBloc.add(
      LoadScoresEvent(
        from: dateTimeRange.start,
        to: dateTimeRange.end,
        mockLoadingTime: mockLoadingTime,
      ),
    );
  }

  void _fetchEarliestScoreDate() {
    _earliestScoreDateCubit.fetchOnce();
  }

  Color _scaffoldFadeColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.surfaceLight
        : Colors.black;
  }

  void _onSelectedDateChange(DateTime date, Timeframe timeframe) {
    setState(() {
      _selectedDate = date;
    });
    _loadScoresForCurrentTimeframe();
  }

  void _onSelectedTimeframeChange(Timeframe timeframe) {
    setState(() {
      _selectedTimeframe = timeframe;
    });
    _loadScoresForCurrentTimeframe();
  }

  List<Widget> _separatedWidgets({
    required List<Widget> widgets,
    required Widget separator,
  }) {
    if (widgets.isEmpty) return <Widget>[];

    final List<Widget> result = <Widget>[];

    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i < widgets.length - 1) {
        result.add(separator);
      }
    }

    return result;
  }

  void _onShowMonthlyAveragesToggle(bool show) {
    setState(() {
      _showMonthlyAverages = show;
    });
  }

  Widget _buildRadialGauge(BuildContext context, double value) {
    return SizedBox(
      height: 200,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ConcentricDotsStackContainer(
              children: <Widget>[
                RadialGauge(
                  value: value.round(),
                  valueColor: widget.scoreType.accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoMetricWidgets(ScoreState scoreState, Score? score) {
    late List<Widget> widgets;

    if (scoreState is ScoreLoading) {
      int cardCount = 0;
      switch (widget.scoreType) {
        case ScoreType.activity:
        case ScoreType.readiness:
          cardCount = 3;
          break;
        case ScoreType.health:
          cardCount = 6;
          break;
      }
      widgets = List<Widget>.generate(
        cardCount,
        (int index) => const ScoreInfoCard.loading(),
      );
    } else {
      double? toDouble(num? number) => number?.toDouble();
      int? round(num? number) => number?.round();

      final List<ScoreInfoCard> activityCards = <ScoreInfoCard>[
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.star, color: AppColors.green),
          title: tr.activePoints,
          value: toDouble(score?.activePoints),
          scoreValue: toDouble(score?.activePointsScore),
          displayValue: (double? value) => '${round(value)} ${tr.valueUnitPts}',
        ),
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.steps, color: AppColors.green),
          title: tr.steps,
          value: toDouble(score?.steps),
          scoreValue: toDouble(score?.stepsScore),
        ),
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.timer, color: AppColors.lightBlue),
          title: tr.moveHours,
          value: toDouble(score?.moveHours),
          scoreValue: toDouble(score?.moveHoursScore),
          displayValue: (double? value) => '${round(value)} ${tr.valueUnitH}',
        ),
      ];

      final List<ScoreInfoCard> readinessCards = <ScoreInfoCard>[
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.moon, color: AppColors.purple),
          title: tr.sleep,
          value: toDouble(score?.sleepMinutes),
          scoreValue: toDouble(score?.sleepScore),
          displayValue: (double? value) =>
              formatMinutesHMin(round(score?.sleepMinutes) ?? 0),
        ),
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.heartRate, color: AppColors.lightBlue),
          title: tr.restingHR,
          value: toDouble(score?.restingHeartRateBpm),
          scoreValue: toDouble(score?.restingHeartRateScore),
          displayValue: (double? value) => '${round(value)} ${tr.valueUnitBpm}',
        ),
        ScoreInfoCard(
          icon: AppIcon(AppIconPaths.heartMonitor, color: AppColors.red),
          title: tr.overnightHRV,
          value: toDouble(score?.overnightHeartRateVarianceMs),
          scoreValue: toDouble(score?.overnightHeartRateVarianceScore),
          displayValue: (double? value) => '${round(value)} ${tr.valueUnitMs}',
        ),
      ];

      switch (widget.scoreType) {
        case ScoreType.activity:
          widgets = activityCards;
          break;

        case ScoreType.readiness:
          widgets = readinessCards;
          break;

        case ScoreType.health:
          widgets = <Widget>[...readinessCards, ...activityCards];
          break;
      }
    }

    return _separatedWidgets(
      widgets: widgets,
      separator: Divider(
        height: 1,
        thickness: 1,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.11),
      ),
    );
  }

  Widget _headerWidgetBuilder(
    Timeframe timeframe,
    ScoreState scoreState,
    Score? score,
  ) {
    if (timeframe != Timeframe.day) {
      return Text(tr.history, style: Theme.of(context).textTheme.titleLarge);
    }
    return GestureDetector(
      onTap: () => _showScoreInfoBottomSheet(context, scoreState, score),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.scoreType.scoreInfoTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.help,
                size: 20,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            generateShortContextualInsight(
              currentDateScore: score,
              scoreType: widget.scoreType,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _showScoreInfoBottomSheet(
    BuildContext context,
    ScoreState scoreState,
    Score? score,
  ) {
    final double sheetHeight = 0.85;
    double gaugeValue = 0;
    final Score nonNullScore = score ?? Score.zero();

    switch (widget.scoreType) {
      case ScoreType.activity:
        gaugeValue = nonNullScore.activityScore.toDouble();
        break;
      case ScoreType.readiness:
        gaugeValue = nonNullScore.readinessScore.toDouble();
        break;
      case ScoreType.health:
        gaugeValue = nonNullScore.healthScore.toDouble();
        break;
    }

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
          minChildSize: sheetHeight,
          maxChildSize: sheetHeight,
          initialChildSize: sheetHeight,
          builder: (_, ScrollController controller) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.only(bottom: 100),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.scoreType.scoreInfoTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: Navigator.of(context).pop,
                        icon: const Icon(Icons.close),
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildRadialGauge(context, gaugeValue),
                  const SizedBox(height: 20),
                  Text(
                    tr.metrics,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ..._buildInfoMetricWidgets(scoreState, score),
                  const SizedBox(height: 20),
                  Text(
                    tr.howItWorks,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.scoreType.scoreDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
      widgets = List<Widget>.generate(
        cardCount,
        (int index) => const ScoreCard.loading(),
      );
    } else {
      final List<Score> scores = scoreState.scores;
      final Score? averageScore = scores.averageScore;
      double? toDouble(num? number) => number?.toDouble();
      int? round(num? number) => number?.round();

      switch (widget.scoreType) {
        case ScoreType.activity:
          widgets = <Widget>[
            ScoreCard(
              icon: AppIcon(AppIconPaths.star, color: AppColors.green),
              title: tr.activePoints,
              value: toDouble(averageScore?.activePoints),
              scoreValue: toDouble(averageScore?.activePointsScore),
              displayValue: (double? value) =>
                  '${round(value)} ${tr.valueUnitPts}',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.steps, color: AppColors.green),
              title: tr.steps,
              value: toDouble(averageScore?.steps),
              scoreValue: toDouble(averageScore?.stepsScore),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.timer, color: AppColors.lightBlue),
              title: tr.moveHours,
              value: toDouble(averageScore?.moveHours),
              scoreValue: toDouble(averageScore?.moveHoursScore),
              displayValue: (double? value) =>
                  '${round(value)} ${tr.valueUnitH}',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.fire, color: AppColors.orange),
              title: tr.activeCalories,
              value: toDouble(averageScore?.activeCalories),
              displayValue: (double? value) =>
                  '${round(value)} ${tr.valueUnitKcal}',
            ),
          ];
          break;
        case ScoreType.readiness:
          widgets = <Widget>[
            ScoreCard(
              icon: AppIcon(AppIconPaths.moon, color: AppColors.purple),
              title: tr.sleep,
              value: toDouble(averageScore?.sleepMinutes),
              scoreValue: toDouble(averageScore?.sleepScore),
              displayValue: averageScore?.sleepMinutes == null
                  ? null
                  : (double? value) =>
                        formatMinutesHM(round(averageScore!.sleepMinutes)!),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.heartRate, color: AppColors.lightBlue),
              title: tr.restingHR,
              value: toDouble(averageScore?.restingHeartRateBpm),
              scoreValue: toDouble(averageScore?.restingHeartRateScore),
              displayValue: (double? value) =>
                  '${round(value)} ${tr.valueUnitBpm}',
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.heartMonitor, color: AppColors.red),
              title: tr.overnightHRV,
              value: toDouble(averageScore?.overnightHeartRateVarianceMs),
              scoreValue: toDouble(
                averageScore?.overnightHeartRateVarianceScore,
              ),
              displayValue: (double? value) =>
                  '${round(value)} ${tr.valueUnitMs}',
            ),
          ];
          break;
        case ScoreType.health:
          widgets = <Widget>[
            ScoreCard(
              icon: AppIcon(AppIconPaths.moon, color: AppColors.purple),
              title: tr.readiness,
              value: toDouble(averageScore?.readinessScore),
              scoreValue: toDouble(averageScore?.readinessScore),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ScoreDetailPage(
                    scoreType: ScoreType.readiness,
                    initialSelectedDate: _selectedDate,
                    initialSelectedTimeframe: _selectedTimeframe,
                    initialShowMonthlyAverages: _showMonthlyAverages,
                  ),
                ),
              ),
            ),
            ScoreCard(
              icon: AppIcon(AppIconPaths.fire, color: AppColors.green),
              title: tr.activity,
              value: toDouble(averageScore?.activityScore),
              scoreValue: toDouble(averageScore?.activityScore),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ScoreDetailPage(
                    scoreType: ScoreType.activity,
                    initialSelectedDate: _selectedDate,
                    initialSelectedTimeframe: _selectedTimeframe,
                    initialShowMonthlyAverages: _showMonthlyAverages,
                  ),
                ),
              ),
            ),
          ];
          break;
      }
    }

    return _separatedWidgets(
      widgets: widgets,
      separator: const SizedBox(height: 10),
    );
  }

  List<Widget> _buildActivitiesWidgets(
    BuildContext context,
    ScoreState scoreState,
  ) {
    late List<Widget> widgets;

    if (scoreState is! ScoreLoaded) {
      widgets = <Widget>[const ScoreActivityCard.loading()];
    } else {
      final List<Score> scores = scoreState.scores;
      final List<ScoreActivity>? activities = scores.sumScore?.activities;

      if (activities == null) {
        widgets = <Widget>[
          Text(tr.noData, style: Theme.of(context).textTheme.bodyMedium),
        ];
      } else if (activities.isEmpty) {
        widgets = <Widget>[
          Text(
            tr.noActivitiesRecorded,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ];
      } else {
        widgets = activities
            .map(
              (ScoreActivity activity) =>
                  ScoreActivityCard.fromActivity(scoreActivity: activity),
            )
            .toList();
      }
    }

    return <Widget>[
      const SizedBox(height: 20),
      Text(tr.activities, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      ..._separatedWidgets(
        widgets: widgets,
        separator: const SizedBox(height: 10),
      ),
      const SizedBox(height: 20),
    ];
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
            colors: <Color>[
              Theme.of(context).scaffoldBackgroundColor,
              _scaffoldFadeColor(context),
            ],
            stops: const <double>[0.5, 0.7],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async => _loadScoresForCurrentTimeframe(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16).copyWith(bottom: 100),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 12),
                BlocBuilder<ScoreBloc, ScoreState>(
                  bloc: _scoreBloc,
                  builder: (BuildContext context, ScoreState scoreState) {
                    if (scoreState is ScoreInitial) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (scoreState is ScoreLoading ||
                        scoreState is ScoreLoaded) {
                      List<Score>? scores;
                      List<DataPoint>? dataPoints;
                      Score? selectedDateScore;
                      final bool isLoading = scoreState is ScoreLoading;

                      if (scoreState is ScoreLoaded) {
                        scores = scoreState.scores;
                        dataPoints = scores
                            .map(
                              (Score score) =>
                                  score.toDataPointByType(widget.scoreType),
                            )
                            .toList();
                        selectedDateScore = scores.firstWhereOrNull(
                          (Score score) =>
                              score.date.isSameDateAs(_selectedDate),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 380,
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:
                                          BlocBuilder<
                                            EarliestScoreDateCubit,
                                            EarliestScoreDateState
                                          >(
                                            bloc: _earliestScoreDateCubit,
                                            builder:
                                                (
                                                  BuildContext context,
                                                  EarliestScoreDateState
                                                  earliestDateState,
                                                ) {
                                                  return TimeframeDataView(
                                                    selectedDate: _selectedDate,
                                                    selectedTimeFrame:
                                                        _selectedTimeframe,
                                                    onSelectedDateChange:
                                                        _onSelectedDateChange,
                                                    onSelectedTimeframeChange:
                                                        _onSelectedTimeframeChange,
                                                    minDate:
                                                        earliestDateState
                                                            is EarliestScoreDateLoaded
                                                        ? earliestDateState.date
                                                        : null,
                                                    dataPoints: dataPoints,
                                                    isLoading: isLoading,
                                                    color: widget
                                                        .scoreType
                                                        .accentColor,
                                                    showMonthlyAverages:
                                                        _showMonthlyAverages,
                                                    onShowMonthlyAveragesToggle:
                                                        _onShowMonthlyAveragesToggle,
                                                    gaugeBuilder:
                                                        _buildRadialGauge,
                                                    headerWidgetBuilder:
                                                        (Timeframe timeframe) =>
                                                            _headerWidgetBuilder(
                                                              timeframe,
                                                              scoreState,
                                                              selectedDateScore,
                                                            ),
                                                  );
                                                },
                                          ),
                                    ),
                                  ],
                                ),

                                if (scoreState is ScoreLoaded &&
                                    _selectedTimeframe == Timeframe.day)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ScoreInsightsView(
                                      items: generateContextualInsights(
                                        _selectedTimeframe,
                                        scores!,
                                        widget.scoreType,
                                        selectedDateScore,
                                      ),
                                      color: _scaffoldFadeColor(context),
                                      constraints: const BoxConstraints(
                                        minHeight: 90,
                                        maxHeight: 90,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tr.metrics,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (_selectedTimeframe != Timeframe.day)
                                Text(
                                  tr.timeframeAvg(
                                    '${_selectedTimeframe.name}${(_selectedTimeframe == Timeframe.year && _showMonthlyAverages) ? 'Monthly' : ''}',
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ..._buildMetricWidgets(scoreState),
                          const SizedBox(height: 10),
                          if (widget.scoreType == ScoreType.activity)
                            ..._buildActivitiesWidgets(context, scoreState),
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
                    } else if (scoreState is ScoreError) {
                      return Center(
                        child: Text('${tr.error}: ${scoreState.message}'),
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
