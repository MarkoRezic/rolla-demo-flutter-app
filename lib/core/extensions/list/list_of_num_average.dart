extension NumListAverage on List<num> {
  double get average {
    if (isEmpty) return 0;
    return map((num a) => a.toDouble()).toList().reduce((double a, double b) => a + b) / length;
  }
}
