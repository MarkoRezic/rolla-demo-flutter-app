import 'package:flutter/material.dart';

TimeOfDay timeOfDatFromMinutes(num minutes) {
  final int totalMinutes = minutes.round();
  final int hour = totalMinutes ~/ 60;
  final int minute = totalMinutes % 60;

  return TimeOfDay(hour: hour, minute: minute);
}

String formatMinutesHM(num minutes) {
  final TimeOfDay timeOfDay = timeOfDatFromMinutes(minutes);

  return '${timeOfDay.hour}h ${timeOfDay.minute}m';
}

String formatMinutesHMin(num minutes) {
  final TimeOfDay timeOfDay = timeOfDatFromMinutes(minutes);

  return '${timeOfDay.hour} h ${timeOfDay.minute} min';
}

String formatDuration(Duration d) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final int hours = d.inHours;
  final int minutes = d.inMinutes.remainder(60);
  final int seconds = d.inSeconds.remainder(60);

  if (hours > 0) {
    return "$hours:${twoDigits(minutes)}:${twoDigits(seconds)}";
  } else {
    return "$minutes:${twoDigits(seconds)}";
  }
}
