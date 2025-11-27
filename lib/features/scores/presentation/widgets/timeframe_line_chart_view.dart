import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/list/list_of_data_points_to_map_by_date_key.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

class TimeframeLineChartView extends StatelessWidget {
  final DateTime selectedDate;
  final Timeframe timeframe;
  final List<DataPoint> dataPoints;
  final double minY;
  final double maxY;
  final List<double> tickMarks;
  final Color? color;
  final Color? gridColor;

  const TimeframeLineChartView({
    Key? key,
    required this.selectedDate,
    required this.timeframe,
    required this.dataPoints,
    this.minY = 0,
    this.maxY = 100,
    this.tickMarks = const [0, 25, 50, 75, 100],
    this.color,
    this.gridColor,
  }) : super(key: key);

  DateTime _monday(DateTime d) {
    return d.subtract(Duration(days: d.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    DateTime? monday;
    late List<DateTime> days;
    final map = dataPoints.toMapByDateKey;
    final List<List<FlSpot>> segments = [];
    List<FlSpot>? currentSegment;

    switch (timeframe) {
      case Timeframe.day:
        monday = _monday(selectedDate);
        days = [selectedDate.copyWith()];
        break;
      case Timeframe.week:
        monday = _monday(selectedDate);
        days = List.generate(7, (i) => monday!.add(Duration(days: i)));
        break;

      case Timeframe.month:
        final start = DateTime(selectedDate.year, selectedDate.month, 1);
        final end = DateTime(
          selectedDate.year,
          selectedDate.month + 1,
          1,
        ).subtract(const Duration(days: 1));
        final daysCount = end.difference(start).inDays + 1;
        days = List.generate(daysCount, (i) => start.add(Duration(days: i)));
        break;

      case Timeframe.year:
        final start = DateTime(selectedDate.year, 1, 1);
        final end = DateTime(selectedDate.year, 12, 31);
        final daysCount = end.difference(start).inDays + 1;
        days = List.generate(daysCount, (i) => start.add(Duration(days: i)));
        break;
    }

    for (var i = 0; i < days.length; i++) {
      final key = DateFormat('yyyy-MM-dd').format(days[i]);
      final dp = map[key];
      if (dp != null && dp.value != null) {
        currentSegment ??= [];
        currentSegment.add(FlSpot(i.toDouble(), dp.value!.clamp(minY, maxY)));
      } else {
        if (currentSegment != null) {
          segments.add(currentSegment);
          currentSegment = null;
        }
      }
    }
    if (currentSegment != null) segments.add(currentSegment);

    final lineBars = segments
        .map(
          (seg) => LineChartBarData(
            spots: seg,
            isCurved: true,
            curveSmoothness: 0,
            isStrokeCapRound: true,
            isStrokeJoinRound: true,
            preventCurveOverShooting: true,
            dotData: FlDotData(show: false),
            color: color,
            barWidth: 1,
          ),
        )
        .toList();

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
          interval: timeframe == Timeframe.year ? 1 : null,
          getTitlesWidget: (value, meta) {
            late String label;
            final locale = Localizations.localeOf(context).toString();

            switch (timeframe) {
              case Timeframe.day:
                final d = days.first;
                label = DateFormat.yMMMd(locale).format(d);
                break;

              case Timeframe.week:
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final d = days[idx];
                label = DateFormat.E(locale).format(d);
                break;

              case Timeframe.month:
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final d = days[idx];
                final showStep = (days.length <= 10) ? 1 : (days.length ~/ 8);
                if (showStep == 0 || idx % showStep != 0)
                  return const SizedBox();
                label = DateFormat.Md(locale).format(d);
                break;

              case Timeframe.year:
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                final d = days[idx];
                // show only mid day of each month
                if (d.day != 15) return const SizedBox.shrink();
                label = DateFormat.MMM(locale).format(d);
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

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (days.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        lineBarsData: lineBars,
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
