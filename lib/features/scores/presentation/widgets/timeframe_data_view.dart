import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:rolla_demo_app/core/extensions/date_time/date_time_start_end_day.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/bar_chart_timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/timeframe_bar_chart_view.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/timeframe_date_selector.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/timeframe_line_chart_view.dart';
import 'package:shimmer/shimmer.dart';

// --- Main Widget ---
typedef OnDateChange =
    void Function(DateTime selectedDate, Timeframe timeframe);
typedef OnTimeframeChange = void Function(Timeframe timeframe);
typedef GaugeBuilder = Widget Function(BuildContext context, double value);

class TimeframeDataView extends StatefulWidget {
  final DateTime selectedDate;
  final Timeframe selectedTimeFrame;
  final OnDateChange onSelectedDateChange;
  final OnTimeframeChange onSelectedTimeframeChange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final List<DataPoint>? dataPoints;
  final bool isLoading;
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final Color? color;
  final Color? tabBarColor;
  final Color? gridColor;
  final double height;
  final GaugeBuilder? gaugeBuilder;
  final Widget Function(Timeframe timeframe)? headerWidgetBuilder;

  const TimeframeDataView({
    Key? key,
    required this.selectedDate,
    required this.selectedTimeFrame,
    required this.onSelectedDateChange,
    required this.onSelectedTimeframeChange,
    this.minDate,
    this.maxDate,
    this.dataPoints,
    this.isLoading = false,
    this.minY = 0,
    this.maxY = 100,
    this.tickMarks = const [0, 25, 50, 75, 100],
    this.color,
    this.tabBarColor,
    this.gridColor,
    this.height = 200,
    this.gaugeBuilder,
    this.headerWidgetBuilder,
  }) : super(key: key);

  @override
  State<TimeframeDataView> createState() => _TimeframeDataViewState();
}

class _TimeframeDataViewState extends State<TimeframeDataView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DateTime _selectedDate;
  late Timeframe _selectedTimeframe;
  bool _showMonthlyAverages = false; // only relevant for 1Y

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedTimeframe = widget.selectedTimeFrame;
    _tabController = TabController(
      length: Timeframe.values.length,
      vsync: this,
    );
    _tabController.index = _timeframeToIndex(_selectedTimeframe);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final timeframe = Timeframe.values[_tabController.index];
      _onTimeframeChange(timeframe);
    });
  }

  @override
  void didUpdateWidget(covariant TimeframeDataView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTimeFrame != widget.selectedTimeFrame) {
      _selectedTimeframe = widget.selectedTimeFrame;
      _tabController.index = _timeframeToIndex(_selectedTimeframe);
    }
    if (oldWidget.selectedDate != widget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
  }

  int _timeframeToIndex(Timeframe t) => Timeframe.values.indexOf(t);

  void _onTimeframeChange(Timeframe t) {
    setState(() => _selectedTimeframe = t);
    widget.onSelectedTimeframeChange(t);
  }

  void _onDateChange(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      widget.onSelectedDateChange(newDate, _selectedTimeframe);
    });
  }

  void _shiftLeft() {
    switch (_selectedTimeframe) {
      case Timeframe.day:
        _onDateChange(_selectedDate.subtract(const Duration(days: 1)));
        break;
      case Timeframe.week:
        _onDateChange(_selectedDate.subtract(const Duration(days: 7)));
        break;
      case Timeframe.month:
        _onDateChange(
          DateTime(
            _selectedDate.year,
            _selectedDate.month - 1,
            _selectedDate.day,
          ),
        );
        break;
      case Timeframe.year:
        _onDateChange(
          DateTime(
            _selectedDate.year - 1,
            _selectedDate.month,
            _selectedDate.day,
          ),
        );
        break;
    }
  }

  void _shiftRight() {
    switch (_selectedTimeframe) {
      case Timeframe.day:
        _onDateChange(_selectedDate.add(const Duration(days: 1)));
        break;
      case Timeframe.week:
        _onDateChange(_selectedDate.add(const Duration(days: 7)));
        break;
      case Timeframe.month:
        _onDateChange(
          DateTime(
            _selectedDate.year,
            _selectedDate.month + 1,
            _selectedDate.day,
          ),
        );
        break;
      case Timeframe.year:
        _onDateChange(
          DateTime(
            _selectedDate.year + 1,
            _selectedDate.month,
            _selectedDate.day,
          ),
        );
        break;
    }
  }

  DateTime get _firstDate =>
      (widget.minDate ?? DateTime(2000)).subtract(Duration(days: 2)).startOfDay;
  DateTime get _lastDate => (widget.maxDate ?? DateTime.now()).startOfDay;

  void Function()? get _onLeftPressed =>
      _selectedDate
          .subtract(const Duration(days: 1))
          .startOfDay
          .isBefore(_firstDate)
      ? null
      : _shiftLeft;
  void Function()? get _onRightPressed =>
      _selectedDate.add(const Duration(days: 1)).startOfDay.isAfter(_lastDate)
      ? null
      : _shiftRight;

  void _toggleShowMonthlyAverages(bool show) {
    setState(() {
      _showMonthlyAverages = show;
    });
  }

  Widget _defaultGaugeBuilder(double gaugeValue) {
    return SizedBox(
      width: widget.height,
      height: widget.height,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: (gaugeValue - widget.minY) / (widget.maxY - widget.minY),
              strokeWidth: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  gaugeValue.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueGauge(BuildContext context) {
    double gaugeValue = 0;
    if (widget.dataPoints != null && widget.dataPoints!.isNotEmpty) {
      final first = widget.dataPoints!.firstWhere(
        (dp) => dp.value != null,
        orElse: () => widget.dataPoints!.first,
      );
      gaugeValue = (first.value) ?? 0;
    }

    if (widget.gaugeBuilder != null) {
      return widget.gaugeBuilder!(context, gaugeValue);
    }

    return _defaultGaugeBuilder(gaugeValue);
  }

  Widget _defaultHeaderWidget(Timeframe timeframe) => const SizedBox.shrink();

  Widget _buildHeaderWidget() {
    return widget.headerWidgetBuilder?.call(_selectedTimeframe) ??
        _defaultHeaderWidget(_selectedTimeframe);
  }

  Widget _bodyForData({required int tabIndex, required Widget child}) {
    if (tabIndex != _tabController.index || widget.isLoading) {
      return Expanded(child: _buildShimmerSkeleton());
    }
    if (widget.dataPoints == null) {
      return Expanded(
        child: Center(
          child: Text(tr.noData, style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }
    // non-null data
    return Container(height: widget.height, child: child);
  }

  Widget _buildShimmerSkeleton() {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: AppTheme.shimmerBase(context),
          highlightColor: AppTheme.shimmerHighlight(context),
          child: Column(
            children: [
              Expanded(child: Container(color: AppTheme.shimmerBase(context))),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: AppTheme.shimmerBase(context),
                blurRadius: 20,
                spreadRadius: 10,
                inset: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tab bar
        Container(
          color: widget.tabBarColor ?? Theme.of(context).colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            tabs: Timeframe.values
                .map((t) => Tab(text: t.shortLabel(context)))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        // Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: Timeframe.values.map((timeframe) {
              late Widget child;
              switch (_selectedTimeframe) {
                case Timeframe.day:
                  child = _buildValueGauge(context);
                  break;
                case Timeframe.week:
                case Timeframe.month:
                case Timeframe.year:
                  child = (timeframe == Timeframe.year && _showMonthlyAverages)
                      ? TimeframeLineChartView(
                          selectedDate: _selectedDate,
                          timeframe: timeframe,
                          dataPoints: widget.dataPoints ?? [],
                          minY: widget.minY,
                          maxY: widget.maxY,
                          tickMarks: widget.tickMarks,
                          color: widget.color,
                          gridColor: widget.gridColor,
                        )
                      : TimeframeBarChartView(
                          selectedDate: _selectedDate,
                          barChartTimeframe: BarChartTimeframe.fromTimeframe(
                            timeframe,
                          ),
                          dataPoints: widget.dataPoints ?? [],
                          minY: widget.minY,
                          maxY: widget.maxY,
                          tickMarks: widget.tickMarks,
                          color: widget.color,
                          gridColor: widget.gridColor,
                        );
                  break;
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildHeaderWidget(),
                      Spacer(),
                      if (timeframe == Timeframe.year)
                        Row(
                          children: [
                            Text(tr.line),
                            SizedBox(width: 10),
                            Switch(
                              value: _showMonthlyAverages,
                              onChanged: _toggleShowMonthlyAverages,
                              activeTrackColor: widget.color,
                            ),
                          ],
                        ),
                      TimeframeDateSelector(
                        selectedDate: _selectedDate,
                        selectedTimeframe: _selectedTimeframe,
                        onLeftPressed: _onLeftPressed,
                        onRightPressed: _onRightPressed,
                        onDateTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: _firstDate,
                            lastDate: _lastDate,
                          );
                          if (picked != null) _onDateChange(picked);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _bodyForData(tabIndex: timeframe.index, child: child),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
