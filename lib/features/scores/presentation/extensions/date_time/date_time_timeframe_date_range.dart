import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/extensions/date_time/date_time_start_end_day.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';

extension DateTimeTimeframeDateRange on DateTime {
  /// Returns a DateTimeRange containing full days for the requested timeframe.
  /// - Week uses ISO-style weeks (Monday = start).
  /// - Both start and end days are included (end is set to 23:59:59.999999).
  DateTimeRange getDateRangeByTimeframe(Timeframe timeframe) {
    // helper: build DateTime preserving timezone
    DateTime _build(DateTime template, int y, int m, int d) =>
        template.isUtc ? DateTime.utc(y, m, d) : DateTime(y, m, d);

    switch (timeframe) {
      case Timeframe.day:
        final start = startOfDay;
        final end = endOfDay;
        return DateTimeRange(start: start, end: end);

      case Timeframe.week:
        // calendar week containing `this`. ISO-like: Monday is weekday == 1
        final monday = this.subtract(Duration(days: this.weekday - 1));
        final sunday = monday.add(const Duration(days: 6));
        return DateTimeRange(start: monday.startOfDay, end: sunday.endOfDay);

      case Timeframe.month:
        // calendar month containing `this`
        final firstOfMonth = _build(this, this.year, this.month, 1);
        // first day of next month (DateTime handles month overflow)
        final firstOfNextMonth = _build(this, this.year, this.month + 1, 1);
        final lastOfMonth = firstOfNextMonth.subtract(const Duration(days: 1));
        return DateTimeRange(
          start: firstOfMonth.startOfDay,
          end: lastOfMonth.endOfDay,
        );

      case Timeframe.year:
        // calendar year containing `this`
        final firstOfYear = _build(this, this.year, 1, 1);
        final firstOfNextYear = _build(this, this.year + 1, 1, 1);
        final lastOfYear = firstOfNextYear.subtract(const Duration(days: 1));
        return DateTimeRange(
          start: firstOfYear.startOfDay,
          end: lastOfYear.endOfDay,
        );
    }
  }
}
