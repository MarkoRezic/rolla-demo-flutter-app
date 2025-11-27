String formatMinutesHM(num minutes) {
  final totalMinutes = minutes.round(); // or .floor() depending on your needs
  final h = totalMinutes ~/ 60;
  final m = totalMinutes % 60;

  return '${h}h ${m}m';
}
