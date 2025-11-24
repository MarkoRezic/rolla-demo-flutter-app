extension NumListAverage on List<num> {
  double get average {
    if (isEmpty) return 0;
    return map((a) => a.toDouble()).toList().reduce((a, b) => a + b) / length;
  }
}
