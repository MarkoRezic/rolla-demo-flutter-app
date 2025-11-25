import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/bar_chart_timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/list/list_of_data_points_to_map_by_date_key.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

class TimeframeBarChartView extends StatelessWidget {
  final DateTime selectedDate;
  final BarChartTimeframe barChartTimeframe;
  final List<DataPoint> dataPoints;
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final String locale;
  final Color? color;
  final Color? gridColor;

  const TimeframeBarChartView({
    Key? key,
    required this.selectedDate,
    required this.barChartTimeframe,
    required this.dataPoints,
    required this.minY,
    required this.maxY,
    required this.tickMarks,
    required this.locale,
    this.color,
    this.gridColor,
  }) : super(key: key);

  DateTime _monday(DateTime d) {
    return d.subtract(Duration(days: d.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    DateTime? monday;
    List<DateTime>? days;
    final year = selectedDate.year;
    final map = dataPoints.toMapByDateKey;
    // bucket by month
    final Map<int, List<double>> buckets = {};
    final groups = <BarChartGroupData>[];
    double groupsSpace;

    switch (barChartTimeframe) {
      case BarChartTimeframe.week:
        groupsSpace = 12;
        monday = _monday(selectedDate);
        days = List.generate(7, (i) => monday!.add(Duration(days: i)));
        for (var i = 0; i < days.length; i++) {
          final key = DateFormat('yyyy-MM-dd').format(days[i]);
          final dp = map[key];
          if (dp != null && dp.value != null) {
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    toY: dp.value!.clamp(minY, maxY),
                    width: 10,
                    borderRadius: BorderRadius.circular(6),
                    color: color,
                  ),
                ],
              ),
            );
          } else {
            // create an empty group with zero-height bar (no visible bar) to keep spacing
            groups.add(BarChartGroupData(x: i, barsSpace: 4, barRods: []));
          }
        }
        break;

      case BarChartTimeframe.month:
        groupsSpace = 6;
        final start = DateTime(selectedDate.year, selectedDate.month, 1);
        final end = DateTime(
          selectedDate.year,
          selectedDate.month + 1,
          1,
        ).subtract(const Duration(days: 1));
        final daysCount = end.difference(start).inDays + 1;
        days = List.generate(daysCount, (i) => start.add(Duration(days: i)));
        for (var i = 0; i < days.length; i++) {
          final key = DateFormat('yyyy-MM-dd').format(days[i]);
          final dp = map[key];
          if (dp != null && dp.value != null) {
            groups.add(
              BarChartGroupData(
                x: i,
                barsSpace: 2,
                barRods: [
                  BarChartRodData(
                    toY: dp.value!.clamp(minY, maxY),
                    width: 6,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              ),
            );
          } else {
            groups.add(BarChartGroupData(x: i, barsSpace: 2, barRods: []));
          }
        }
        break;

      case BarChartTimeframe.twelveMonths:
        groupsSpace = 8;
        for (final dp in dataPoints) {
          if (dp.date.year != year) continue;
          if (dp.value == null) continue;
          buckets.putIfAbsent(dp.date.month, () => []).add(dp.value!);
        }
        for (var m = 1; m <= 12; m++) {
          final vals = buckets[m];
          if (vals == null || vals.isEmpty) {
            groups.add(BarChartGroupData(x: m - 1, barRods: []));
          } else {
            final avg = vals.reduce((a, b) => a + b) / vals.length;
            groups.add(
              BarChartGroupData(
                x: m - 1,
                barRods: [
                  BarChartRodData(
                    toY: avg.clamp(minY, maxY),
                    width: 18,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            );
          }
        }
        break;
    }

    final _gridColor = gridColor ?? Colors.grey.withValues(alpha: 0.3);

    final titlesData = FlTitlesData(
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: (tickMarks.length > 1)
              ? (tickMarks[1] - tickMarks[0])
              : null,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                value.toInt().toString(),
                style: const TextStyle(
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

            switch (barChartTimeframe) {
              case BarChartTimeframe.week:
                final idx = value.toInt();
                if (idx < 0 || idx >= days!.length) return const SizedBox();
                final d = days[idx];
                label = DateFormat.E(locale).format(d);
                break;

              case BarChartTimeframe.month:
                final idx = value.toInt();
                if (idx < 0 || idx >= days!.length) return const SizedBox();
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
              child: Text(label, style: const TextStyle(fontSize: 10)),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: minY,
        groupsSpace: groupsSpace,
        barGroups: groups,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: (tickMarks.length > 1)
              ? (tickMarks[1] - tickMarks[0])
              : null,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: _gridColor,
              strokeWidth: 1,
              dashArray: null, // solid line
            );
          },
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(y: minY, color: _gridColor, strokeWidth: 1),
            HorizontalLine(y: maxY, color: _gridColor, strokeWidth: 1),
          ],
        ),
        titlesData: titlesData,
        borderData: FlBorderData(show: false),
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
