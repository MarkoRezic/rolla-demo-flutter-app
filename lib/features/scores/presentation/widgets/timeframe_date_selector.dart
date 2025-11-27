import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';

class TimeframeDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Timeframe selectedTimeframe;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;
  final VoidCallback onDateTap;

  const TimeframeDateSelector({
    Key? key,
    required this.selectedDate,
    required this.selectedTimeframe,
    this.onLeftPressed,
    this.onRightPressed,
    required this.onDateTap,
  }) : super(key: key);

  DateTime _mondayOfWeek(DateTime date) {
    final dow = date.weekday; // Monday is 1
    return date.subtract(Duration(days: dow - 1));
  }

  DateFormat _dateFormat(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    switch (selectedTimeframe) {
      case Timeframe.day:
        return DateFormat.MMMd(locale);
      case Timeframe.week:
        return DateFormat.MMMd(locale);
      case Timeframe.month:
        return DateFormat.MMMM(locale);
      case Timeframe.year:
        return DateFormat.y(locale);
    }
  }

  String _label(BuildContext context) {
    final DateFormat dateFormat = _dateFormat(context);
    switch (selectedTimeframe) {
      case Timeframe.day:
        return dateFormat.format(selectedDate);
      case Timeframe.week:
        final monday = _mondayOfWeek(selectedDate);
        final sunday = monday.add(const Duration(days: 6));
        return '${dateFormat.format(monday)} — ${dateFormat.format(sunday)}';
      case Timeframe.month:
        return dateFormat.format(selectedDate);
      case Timeframe.year:
        return dateFormat.format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onLeftPressed,
          icon: const Icon(Icons.chevron_left),
        ),
        GestureDetector(
          onTap: onDateTap,
          child: Row(
            children: [
              Text(
                _label(context),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRightPressed,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
