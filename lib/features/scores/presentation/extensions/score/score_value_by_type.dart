import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';

extension ScoreValueByType on Score {
  int scoreValueByType(ScoreType scoreType) {
    switch (scoreType) {
      case ScoreType.activity:
        return activityScore;
      case ScoreType.readiness:
        return readinessScore;
      case ScoreType.health:
        return healthScore;
    }
  }
}
