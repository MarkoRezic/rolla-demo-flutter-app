import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/extensions/date_time/date_time_start_end_day.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';

extension DateTimeTimeframeDateRange on DateTime {
  /// Returns a DateTimeRange containing full days for the requested timeframe.
  /// - Week uses ISO-style weeks (Monday = start).
  /// - Both start and end days are included (end is set to 23:59:59.999999).
  DateTimeRange getDateRangeByTimeframe(Timeframe timeframe) {
    // helper: build DateTime preserving timezone
    DateTime build(DateTime template, int y, int m, int d) =>
        template.isUtc ? DateTime.utc(y, m, d) : DateTime(y, m, d);

    switch (timeframe) {
      case Timeframe.day:
        final DateTime start = startOfDay;
        final DateTime end = endOfDay;
        return DateTimeRange(start: start, end: end);

      case Timeframe.week:
        // calendar week containing `this`. ISO-like: Monday is weekday == 1
        final DateTime monday = subtract(Duration(days: weekday - 1));
        final DateTime sunday = monday.add(const Duration(days: 6));
        return DateTimeRange(start: monday.startOfDay, end: sunday.endOfDay);

      case Timeframe.month:
        // calendar month containing `this`
        final DateTime firstOfMonth = build(this, year, month, 1);
        // first day of next month (DateTime handles month overflow)
        final DateTime firstOfNextMonth = build(this, year, month + 1, 1);
        final DateTime lastOfMonth = firstOfNextMonth.subtract(const Duration(days: 1));
        return DateTimeRange(
          start: firstOfMonth.startOfDay,
          end: lastOfMonth.endOfDay,
        );

      case Timeframe.year:
        // calendar year containing `this`
        final DateTime firstOfYear = build(this, year, 1, 1);
        final DateTime firstOfNextYear = build(this, year + 1, 1, 1);
        final DateTime lastOfYear = firstOfNextYear.subtract(const Duration(days: 1));
        return DateTimeRange(
          start: firstOfYear.startOfDay,
          end: lastOfYear.endOfDay,
        );
    }
  }
}
