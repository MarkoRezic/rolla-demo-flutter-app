import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';

enum BarChartTimeframe {
  week,
  month,
  twelveMonths;

  static BarChartTimeframe fromTimeframe(Timeframe timeframe) {
    switch (timeframe) {
      case Timeframe.day:
      case Timeframe.week:
        return week;
      case Timeframe.month:
        return month;
      case Timeframe.year:
        return twelveMonths;
    }
  }
}
