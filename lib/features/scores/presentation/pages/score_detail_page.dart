import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/date_time/date_time_timeframe_date_range.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/score/score_to_data_point_by_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/radial_gauge.dart';
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            tr.about,
                            style: Theme.of(context).textTheme.titleMedium,
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
