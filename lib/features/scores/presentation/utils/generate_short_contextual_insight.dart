import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';

// A helper class to rank insights by severity
class _Insight {
  final String text;
  final int priority; // 0 = low (worst), 1 = ok, 2 = good
  _Insight(this.text, this.priority);
}

String generateShortContextualInsight({
  required Score? currentDateScore,
  required ScoreType scoreType,
}) {
  if (currentDateScore == null) return '';

  final s = currentDateScore;

  const int good = 80;
  const int ok = 60;

  final List<_Insight> pool = [];

  void add(int scoreValue, String goodKey, String okKey, String lowKey) {
    if (scoreValue >= good) {
      pool.add(_Insight(goodKey, 2));
    } else if (scoreValue >= ok) {
      pool.add(_Insight(okKey, 1));
    } else {
      pool.add(_Insight(lowKey, 0));
    }
  }

  // ----- Collect insights based on scoreType -----

  if (scoreType == ScoreType.activity || scoreType == ScoreType.health) {
    add(
      s.activePointsScore,
      tr.shortActivePointsGood,
      tr.shortActivePointsOk,
      tr.shortActivePointsLow,
    );
    add(s.stepsScore, tr.shortStepsGood, tr.shortStepsOk, tr.shortStepsLow);
    add(
      s.moveHoursScore,
      tr.shortMoveHoursGood,
      tr.shortMoveHoursOk,
      tr.shortMoveHoursLow,
    );
  }

  if (scoreType == ScoreType.readiness || scoreType == ScoreType.health) {
    add(
      s.sleepScore,
      tr.shortSleepWellRested,
      tr.shortSleepOkay,
      tr.shortSleepShort,
    );
    add(
      s.restingHeartRateScore,
      tr.shortRestingHrGood,
      tr.shortRestingHrOk,
      tr.shortRestingHrHigh,
    );
    add(
      s.overnightHeartRateVarianceScore,
      tr.shortHrvGood,
      tr.shortHrvOk,
      tr.shortHrvLow,
    );
  }

  if (scoreType == ScoreType.health) {
    add(
      s.readinessScore,
      tr.shortReadinessGood,
      tr.shortReadinessOk,
      tr.shortReadinessLow,
    );
    add(
      s.activityScore,
      tr.shortActivityGood,
      tr.shortActivityOk,
      tr.shortActivityLow,
    );
  }

  if (pool.isEmpty) return '';

  // ----- Pick the most meaningful insight -----
  pool.sort((a, b) => a.priority.compareTo(b.priority));

  // priority = 0 (worst), 1 (ok), 2 (good)
  return pool.first.text;
}
