import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';

abstract class ScoreRepository {
  Future<Either<Failure, List<Score>>> getScores({
    DateTime? from,
    DateTime? to,
  });
}
