import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/data/datasources/local_json_datasource.dart';
import 'package:rolla_demo_app/features/scores/data/models/score_activity_record.dart';
import 'package:rolla_demo_app/features/scores/data/models/score_record.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score_activity.dart';
import 'package:rolla_demo_app/features/scores/domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final LocalJsonDataSource dataSource;

  ScoreRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Score>>> getScores({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final allScores = await dataSource.loadAll();

      final filtered = allScores.where((score) {
        final byFrom =
            from == null ||
            score.date.isAfter(from) ||
            score.date.isAtSameMomentAs(from);
        final byTo =
            to == null ||
            score.date.isBefore(to) ||
            score.date.isAtSameMomentAs(to);
        return byFrom && byTo;
      }).toList();

      final domainList = filtered.map(_mapScoreRecordToDomain).toList();

      return right(domainList);
    } catch (e, st) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getEarliestScoreDate({
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final result = await getScores(from: from, to: to);

      switch (result) {
        case Left(:final value):
          return left(value);

        case Right(:final value):
          if (value.isEmpty) return right(null);

          final earliest = value
              .map((s) => s.date)
              .reduce((a, b) => a.isBefore(b) ? a : b);

          return right(earliest);
      }

      return right(null);
    } catch (e, st) {
      return left(Failure(e.toString()));
    }
  }

  Score _mapScoreRecordToDomain(ScoreRecord r) {
    return Score(
      id: r.id,
      date: r.date,
      sleepMinutes: r.sleepMinutes,
      restingHeartRateBpm: r.restingHeartRateBpm,
      overnightHeartRateVarianceMs: r.overnightHeartRateVarianceMs,
      activePoints: r.activePoints,
      steps: r.steps,
      moveHours: r.moveHours,
      activeCalories: r.activeCalories,
      activities: r.activities.map(_mapActivityRecordToDomain).toList(),
    );
  }

  ScoreActivity _mapActivityRecordToDomain(ScoreActivityRecord ar) {
    return ScoreActivity(
      id: ar.id,
      category: ar.category,
      durationSeconds: ar.durationSeconds,
      calories: ar.calories,
    );
  }
}
