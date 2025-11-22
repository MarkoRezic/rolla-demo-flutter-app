import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';

class TrendChart extends StatelessWidget {
  final List<FlSpot> spots;
  final String type;

  const TrendChart({Key? key, required this.spots, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.accentFor(type);
    if (spots.isEmpty) {
      return Center(child: Text('No data'));
    }
    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: accent,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
