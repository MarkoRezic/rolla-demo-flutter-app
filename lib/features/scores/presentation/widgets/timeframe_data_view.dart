import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';
import 'package:shimmer/shimmer.dart';

// --- Main Widget ---
typedef OnDateChange =
    void Function(DateTime selectedDate, Timeframe timeframe);
typedef OnTimeframeChange = void Function(Timeframe timeframe);
typedef GaugeBuilder = Widget Function(BuildContext context, double value);

class TimeframeDataView extends StatefulWidget {
  // required
  final DateTime selectedDate;
  final Timeframe selectedTimeFrame;
  final OnDateChange onSelectedDateChange;
  final OnTimeframeChange onSelectedTimeframeChange;

  // data
  final List<DataPoint>? dataPoints;
  final bool isLoading;

  // optional
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final GaugeBuilder? gaugeBuilder;

  const TimeframeDataView({
    Key? key,
    required this.selectedDate,
    required this.selectedTimeFrame,
    required this.onSelectedDateChange,
    required this.onSelectedTimeframeChange,
    this.dataPoints,
    this.isLoading = false,
    this.minY = 0,
    this.maxY = 100,
    this.tickMarks = const [0, 25, 50, 75, 100],
    this.gaugeBuilder,
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
    setState(() => _selectedDate = newDate);
    widget.onSelectedDateChange(newDate, _selectedTimeframe);
  }

  // move left/right depending on current timeframe
  void _shiftLeft() {
    switch (_selectedTimeframe) {
      case Timeframe.day:
        _onDateChange(_selectedDate.subtract(const Duration(days: 1)));
        break;
      case Timeframe.week:
        _onDateChange(_selectedDate.subtract(const Duration(days: 7)));
        break;
      case Timeframe.month:
        // ASSUMPTION: shift by one month (user text ambiguous)
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

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tab bar
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: Timeframe.values
              .map((t) => Tab(text: t.shortLabel(context)))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _build1DView(context, locale),
              _build7DView(context, locale),
              _build30DView(context, locale),
              _build1YView(context, locale),
            ],
          ),
        ),
      ],
    );
  }

  // --- 1D View: single value radial gauge + date selector with chevrons ---
  Widget _build1DView(BuildContext context, String locale) {
    return _buildContentWrapper(
      child: Column(
        children: [
          DateSelector1D(
            selectedDate: _selectedDate,
            onLeft: _shiftLeft,
            onRight: _shiftRight,
            onDateTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) _onDateChange(picked);
            },
            locale: locale,
          ),
          const SizedBox(height: 16),
          _bodyForData(
            tabIndex: Timeframe.day.index,
            child: _oneValueGauge(context),
          ),
        ],
      ),
    );
  }

  Widget _oneValueGauge(BuildContext context) {
    // pick the first available value in dataPoints (as requested)
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

    // Default simple placeholder gauge
    return SizedBox(
      width: 200,
      height: 200,
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
                Text('value', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- 7D view: bar chart with Monday-Sunday week range ---
  Widget _build7DView(BuildContext context, String locale) {
    return _buildContentWrapper(
      child: Column(
        children: [
          DateSelectorRangeWeek(
            selectedDate: _selectedDate,
            onLeft: _shiftLeft,
            onRight: _shiftRight,
            locale: locale,
          ),
          const SizedBox(height: 12),
          _bodyForData(
            tabIndex: Timeframe.week.index,
            child: Expanded(
              child: BarChart7D(
                selectedDate: _selectedDate,
                dataPoints: widget.dataPoints ?? [],
                minY: widget.minY,
                maxY: widget.maxY,
                tickMarks: widget.tickMarks,
                locale: locale,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 30D view: month view, bar chart, hide some x labels to avoid clutter ---
  Widget _build30DView(BuildContext context, String locale) {
    return _buildContentWrapper(
      child: Column(
        children: [
          DateSelectorRangeMonth(
            selectedDate: _selectedDate,
            onLeft: _shiftLeft,
            onRight: _shiftRight,
            locale: locale,
          ),
          const SizedBox(height: 12),
          _bodyForData(
            tabIndex: Timeframe.month.index,
            child: Expanded(
              child: BarChart30D(
                selectedDate: _selectedDate,
                dataPoints: widget.dataPoints ?? [],
                minY: widget.minY,
                maxY: widget.maxY,
                tickMarks: widget.tickMarks,
                locale: locale,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 1Y view: line chart, toggle monthly averages (bar chart) ---
  Widget _build1YView(BuildContext context, String locale) {
    return _buildContentWrapper(
      child: Column(
        children: [
          DateSelectorRangeYear(
            selectedDate: _selectedDate,
            onLeft: _shiftLeft,
            onRight: _shiftRight,
            locale: locale,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Show monthly averages'),
              Switch(
                value: _showMonthlyAverages,
                onChanged: (v) => setState(() => _showMonthlyAverages = v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _bodyForData(
            tabIndex: Timeframe.year.index,
            child: Expanded(
              child: _showMonthlyAverages
                  ? BarChartYearlyAverages(
                      selectedDate: _selectedDate,
                      dataPoints: widget.dataPoints ?? [],
                      minY: widget.minY,
                      maxY: widget.maxY,
                      tickMarks: widget.tickMarks,
                      locale: locale,
                    )
                  : LineChartYear(
                      selectedDate: _selectedDate,
                      dataPoints: widget.dataPoints ?? [],
                      minY: widget.minY,
                      maxY: widget.maxY,
                      tickMarks: widget.tickMarks,
                      locale: locale,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers & wrappers for loading/no data ---
  Widget _buildContentWrapper({required Widget child}) {
    return Padding(padding: const EdgeInsets.all(12.0), child: child);
  }

  Widget _bodyForData({required int tabIndex, required Widget child}) {
    if (tabIndex != _tabController.index || widget.isLoading) {
      return Expanded(child: _buildShimmerSkeleton());
    }
    if (widget.dataPoints == null) {
      return Expanded(
        child: Center(
          child: Text(
            'No data available',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    // non-null data
    return child;
  }

  Widget _buildShimmerSkeleton() {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).scaffoldBackgroundColor,
          highlightColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.surfaceContainer,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor,
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
}

// ----------------------------
// --- Date selector widgets - small and reusable
// ----------------------------
class DateSelector1D extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onDateTap;
  final String locale;

  const DateSelector1D({
    Key? key,
    required this.selectedDate,
    required this.onLeft,
    required this.onRight,
    required this.onDateTap,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = DateFormat.yMMMMd(locale).format(selectedDate);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onLeft, icon: const Icon(Icons.chevron_left)),
        GestureDetector(
          onTap: onDateTap,
          child: Row(
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 6),
              const Icon(Icons.calendar_today, size: 18),
            ],
          ),
        ),
        IconButton(onPressed: onRight, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class DateSelectorRangeWeek extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final String locale;

  const DateSelectorRangeWeek({
    Key? key,
    required this.selectedDate,
    required this.onLeft,
    required this.onRight,
    required this.locale,
  }) : super(key: key);

  DateTime _mondayOfWeek(DateTime date) {
    final dow = date.weekday; // Monday is 1
    return date.subtract(Duration(days: dow - 1));
  }

  @override
  Widget build(BuildContext context) {
    final monday = _mondayOfWeek(selectedDate);
    final sunday = monday.add(const Duration(days: 6));
    final fmt = DateFormat.yMMMd(locale);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onLeft, icon: const Icon(Icons.chevron_left)),
        Text(
          '${fmt.format(monday)} — ${fmt.format(sunday)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        IconButton(onPressed: onRight, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class DateSelectorRangeMonth extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final String locale;

  const DateSelectorRangeMonth({
    Key? key,
    required this.selectedDate,
    required this.onLeft,
    required this.onRight,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final start = DateTime(selectedDate.year, selectedDate.month, 1);
    final end = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      1,
    ).subtract(const Duration(days: 1));
    final fmt = DateFormat.yMMMd(locale);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onLeft, icon: const Icon(Icons.chevron_left)),
        Text(
          '${fmt.format(start)} — ${fmt.format(end)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        IconButton(onPressed: onRight, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class DateSelectorRangeYear extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final String locale;

  const DateSelectorRangeYear({
    Key? key,
    required this.selectedDate,
    required this.onLeft,
    required this.onRight,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final start = DateTime(selectedDate.year, 1, 1);
    final end = DateTime(selectedDate.year, 12, 31);
    final fmt = DateFormat.y(locale);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onLeft, icon: const Icon(Icons.chevron_left)),
        Text(
          '${fmt.format(start)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8),
        Text('-', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 8),
        Text(
          '${fmt.format(end)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        IconButton(onPressed: onRight, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}
