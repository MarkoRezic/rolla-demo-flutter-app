import 'package:flutter/material.dart';

TimeOfDay timeOfDatFromMinutes(num minutes) {
  final totalMinutes = minutes.round();
  final hour = totalMinutes ~/ 60;
  final minute = totalMinutes % 60;

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
