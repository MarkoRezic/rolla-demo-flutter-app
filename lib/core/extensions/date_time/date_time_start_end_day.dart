extension DateTimeStartEndDay on DateTime {
  /// Returns a new DateTime at 00:00:00.000 of the same date.
  DateTime get startOfDay {
    return isUtc ? DateTime.utc(year, month, day) : DateTime(year, month, day);
  }

  /// Returns a new DateTime at 23:59:59.999 of the same date.
  DateTime get endOfDay {
    return isUtc
        ? DateTime.utc(year, month, day, 23, 59, 59, 999)
        : DateTime(year, month, day, 23, 59, 59, 999);
  }
}
