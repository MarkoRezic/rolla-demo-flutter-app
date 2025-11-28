import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';

extension ListOfScoresAverageMetrics on List<Score> {
  Score? get sumScore =>
      isEmpty ? null : reduce((Score combinedScore, Score score) => combinedScore + score);

  Score? get averageScore {
    final Score? sum = sumScore;
    if (isEmpty || sum == null) return null;

    return sum / length.toDouble();
  }
}
