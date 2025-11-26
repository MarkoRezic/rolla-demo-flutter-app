import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/bar_chart_timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/list/list_of_data_points_to_map_by_date_key.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

class TimeframeBarChartView extends StatefulWidget {
  final DateTime selectedDate;
  final BarChartTimeframe barChartTimeframe;
  final List<DataPoint> dataPoints;
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final Color? color;
  final Color? gridColor;

  const TimeframeBarChartView({
    Key? key,
    required this.selectedDate,
    required this.barChartTimeframe,
    required this.dataPoints,
    this.minY = 0,
    this.maxY = 100,
    this.tickMarks = const [0, 25, 50, 75, 100],
    this.color,
    this.gridColor,
  }) : super(key: key);

  @override
  State<TimeframeBarChartView> createState() => _TimeframeBarChartViewState();
}

class _TimeframeBarChartViewState extends State<TimeframeBarChartView> {
  /// Controls whether we show real values (true) or zeros (false).
  /// We start with false and flip to true after the first frame to trigger animation.
  bool _showRealValues = false;

  @override
  void initState() {
    super.initState();
    // Trigger a rebuild after the first frame so FLChart will animate from zeros -> actual.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _showRealValues = true);
      }
    });
  }

  DateTime _monday(DateTime d) {
    return d.subtract(Duration(days: d.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    DateTime monday = _monday(widget.selectedDate);
    List<DateTime> days = [];
    final year = widget.selectedDate.year;
    final map = widget.dataPoints.toMapByDateKey;
    final groups = <BarChartGroupData>[];
    double groupsSpace = 12;

    switch (widget.barChartTimeframe) {
      case BarChartTimeframe.week:
        groupsSpace = 12;
        days = List.generate(7, (i) => monday.add(Duration(days: i)));
        for (var i = 0; i < days.length; i++) {
          final key = DateFormat('yyyy-MM-dd').format(days[i]);
          final dp = map[key];
          if (dp != null && dp.value != null) {
            final target = dp.value!.clamp(widget.minY, widget.maxY);
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    // animate from 0 -> target
                    fromY: widget.minY,
                    toY: _showRealValues ? target : widget.minY,
                    borderRadius: BorderRadius.circular(6),
                    color: widget.color,
                  ),
                ],
              ),
            );
          } else {
            // keep spacing with an invisible zero-height rod so alignment is stable
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    fromY: widget.minY,
                    toY: widget.minY,
                    width: 6,
                    color: Colors.transparent,
                  ),
                ],
              ),
            );
          }
        }
        break;

      case BarChartTimeframe.month:
        groupsSpace = 6;
        final start = DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month,
          1,
        );
        final end = DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month + 1,
          1,
        ).subtract(const Duration(days: 1));
        final daysCount = end.difference(start).inDays + 1;
        days = List.generate(daysCount, (i) => start.add(Duration(days: i)));
        for (var i = 0; i < days.length; i++) {
          final key = DateFormat('yyyy-MM-dd').format(days[i]);
          final dp = map[key];
          if (dp != null && dp.value != null) {
            final target = dp.value!.clamp(widget.minY, widget.maxY);
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 2,
                barRods: [
                  BarChartRodData(
                    fromY: widget.minY,
                    toY: _showRealValues ? target : widget.minY,
                    width: 6,
                    borderRadius: BorderRadius.circular(6),
                    color: widget.color,
                  ),
                ],
              ),
            );
          } else {
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 2,
                barRods: [
                  BarChartRodData(
                    fromY: widget.minY,
                    toY: widget.minY,
                    width: 6,
                    color: Colors.transparent,
                  ),
                ],
              ),
            );
          }
        }
        break;

      case BarChartTimeframe.twelveMonths:
        groupsSpace = 8;
        final buckets = <int, List<double>>{};
        for (final dp in widget.dataPoints) {
          if (dp.date.year != year) continue;
          if (dp.value == null) continue;
          buckets.putIfAbsent(dp.date.month, () => []).add(dp.value!);
        }
        for (var m = 1; m <= 12; m++) {
          final vals = buckets[m];
          if (vals == null || vals.isEmpty) {
            groups.add(
              BarChartGroupData(
                x: m - 1,
                barRods: [
                  BarChartRodData(
                    fromY: widget.minY,
                    toY: widget.minY,
                    color: Colors.transparent,
                  ),
                ],
              ),
            );
          } else {
            final avg = vals.reduce((a, b) => a + b) / vals.length;
            final target = avg.clamp(widget.minY, widget.maxY);
            groups.add(
              BarChartGroupData(
                x: m - 1,
                barRods: [
                  BarChartRodData(
                    fromY: widget.minY,
                    toY: _showRealValues ? target : widget.minY,
                    borderRadius: BorderRadius.circular(8),
                    color: widget.color,
                  ),
                ],
              ),
            );
          }
        }
        break;
    }

    final _gridColor = widget.gridColor ?? Colors.grey.withOpacity(0.3);

    final titlesData = FlTitlesData(
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: (widget.tickMarks.length > 1)
              ? (widget.tickMarks[1] - widget.tickMarks[0])
              : null,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            late String label;
            final locale = Localizations.localeOf(context).toString();

            switch (widget.barChartTimeframe) {
              case BarChartTimeframe.week:
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final d = days[idx];
                label = DateFormat.E(locale).format(d);
                break;

              case BarChartTimeframe.month:
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final d = days[idx];
                final showStep = (days.length <= 10) ? 1 : (days.length ~/ 8);
                if (showStep == 0 || idx % showStep != 0)
                  return const SizedBox();
                label = DateFormat.Md(locale).format(d);
                break;

              case BarChartTimeframe.twelveMonths:
                final idx = value.toInt();
                if (idx < 0 || idx > 11) return const SizedBox();
                final date = DateTime(2000, idx + 1, 1);
                label = DateFormat.MMM(locale).format(date);
                break;
            }

            return SideTitleWidget(
              meta: meta,
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 10,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );

    return BarChart(
      BarChartData(
        maxY: widget.maxY,
        minY: widget.minY,
        groupsSpace: groupsSpace,
        barGroups: groups,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: (widget.tickMarks.length > 1)
              ? (widget.tickMarks[1] - widget.tickMarks[0])
              : null,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: _gridColor, strokeWidth: 1, dashArray: null);
          },
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: widget.minY, color: _gridColor, strokeWidth: 1),
            HorizontalLine(y: widget.maxY, color: _gridColor, strokeWidth: 1),
          ],
        ),
        titlesData: titlesData,
        borderData: FlBorderData(show: false),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }
}
