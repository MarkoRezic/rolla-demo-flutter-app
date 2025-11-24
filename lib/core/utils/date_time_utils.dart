import 'package:rolla_demo_app/core/extensions/date_time/date_time_start_end_day.dart';

DateTime startOfCurrentDay({bool? utc = true}) {
  DateTime now = DateTime.now();
  if (utc == true) {
    now = now.toUtc();
  }
  return now.startOfDay;
}

DateTime endOfCurrentDay({bool? utc = true}) {
  DateTime now = DateTime.now();
  if (utc == true) {
    now = now.toUtc();
  }
  return now.endOfDay;
}
