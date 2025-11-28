import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/list/list_of_data_points_to_map_by_date_key.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

class TimeframeLineChartView extends StatelessWidget {
  const TimeframeLineChartView({
    super.key,
    required this.selectedDate,
    required this.timeframe,
    required this.dataPoints,
    this.minY = 0,
    this.maxY = 100,
    this.tickMarks = const <double>[0, 25, 50, 75, 100],
    this.color,
    this.gridColor,
  });
  final DateTime selectedDate;
  final Timeframe timeframe;
  final List<DataPoint> dataPoints;
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final Color? color;
  final Color? gridColor;

  DateTime _monday(DateTime d) {
    return d.subtract(Duration(days: d.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    DateTime? monday;
    late List<DateTime> days;
    final Map<String, DataPoint?> map = dataPoints.toMapByDateKey;
    final List<List<FlSpot>> segments = <List<FlSpot>>[];
    List<FlSpot>? currentSegment;

    switch (timeframe) {
      case Timeframe.day:
        monday = _monday(selectedDate);
        days = <DateTime>[selectedDate.copyWith()];
        break;
      case Timeframe.week:
        monday = _monday(selectedDate);
        days = List<DateTime>.generate(
          7,
          (int i) => monday!.add(Duration(days: i)),
        );
        break;

      case Timeframe.month:
        final DateTime start = DateTime(selectedDate.year, selectedDate.month);
        final DateTime end = DateTime(
          selectedDate.year,
          selectedDate.month + 1,
        ).subtract(const Duration(days: 1));
        final int daysCount = end.difference(start).inDays + 1;
        days = List<DateTime>.generate(
          daysCount,
          (int i) => start.add(Duration(days: i)),
        );
        break;

      case Timeframe.year:
        final DateTime start = DateTime(selectedDate.year);
        final DateTime end = DateTime(selectedDate.year, 12, 31);
        final int daysCount = end.difference(start).inDays + 1;
        days = List<DateTime>.generate(
          daysCount,
          (int i) => start.add(Duration(days: i)),
        );
        break;
    }

    for (int i = 0; i < days.length; i++) {
      final String key = DateFormat('yyyy-MM-dd').format(days[i]);
      final DataPoint? dp = map[key];
      if (dp != null && dp.value != null) {
        currentSegment ??= <FlSpot>[];
        currentSegment.add(FlSpot(i.toDouble(), dp.value!.clamp(minY, maxY)));
      } else {
        if (currentSegment != null) {
          segments.add(currentSegment);
          currentSegment = null;
        }
      }
    }
    if (currentSegment != null) segments.add(currentSegment);

    final List<LineChartBarData> lineBars = segments
        .map(
          (List<FlSpot> seg) => LineChartBarData(
            spots: seg,
            isCurved: true,
            curveSmoothness: 0,
            isStrokeCapRound: true,
            isStrokeJoinRound: true,
            preventCurveOverShooting: true,
            dotData: const FlDotData(show: false),
            color: color,
            barWidth: 1,
          ),
        )
        .toList();

    final Color gridColorFinal =
        gridColor ?? Colors.grey.withValues(alpha: 0.3);

    final FlTitlesData titlesData = FlTitlesData(
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: (tickMarks.length > 1)
              ? (tickMarks[1] - tickMarks[0])
              : null,
          reservedSize: 28,
          getTitlesWidget: (double value, TitleMeta meta) {
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
          interval: timeframe == Timeframe.year ? 1 : null,
          getTitlesWidget: (double value, TitleMeta meta) {
            late String label;
            final String locale = Localizations.localeOf(context).toString();

            switch (timeframe) {
              case Timeframe.day:
                final DateTime d = days.first;
                label = DateFormat.yMMMd(locale).format(d);
                break;

              case Timeframe.week:
                final int idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final DateTime d = days[idx];
                label = DateFormat.E(locale).format(d);
                break;

              case Timeframe.month:
                final int idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final DateTime d = days[idx];
                final int showStep = (days.length <= 10)
                    ? 1
                    : (days.length ~/ 8);
                if (showStep == 0 || idx % showStep != 0) {
                  return const SizedBox();
                }
                label = DateFormat.Md(locale).format(d);
                break;

              case Timeframe.year:
                final int idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final DateTime d = days[idx];
                // show only mid day of each month
                if (d.day != 15) return const SizedBox.shrink();
                label = DateFormat.MMM(locale).format(d);
                break;
            }

            return SideTitleWidget(
              meta: meta,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(),
      topTitles: const AxisTitles(),
    );

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (days.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        lineBarsData: lineBars,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: (tickMarks.length > 1)
              ? (tickMarks[1] - tickMarks[0])
              : null,
          getDrawingHorizontalLine: (double value) {
            return FlLine(color: gridColorFinal, strokeWidth: 1);
          },
        ),
        extraLinesData: ExtraLinesData(
          horizontalLines: <HorizontalLine>[
            HorizontalLine(y: minY, color: gridColorFinal, strokeWidth: 1),
            HorizontalLine(y: maxY, color: gridColorFinal, strokeWidth: 1),
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
