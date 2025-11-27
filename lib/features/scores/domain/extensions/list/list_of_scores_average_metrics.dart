import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';

extension ListOfScoresAverageMetrics on List<Score> {
  Score? get sumScore =>
      isEmpty ? null : reduce((combinedScore, score) => combinedScore + score);

  Score? get averageScore {
    Score? sum = sumScore;
    if (isEmpty || sum == null) return null;

    return sum / length.toDouble();
  }
}
