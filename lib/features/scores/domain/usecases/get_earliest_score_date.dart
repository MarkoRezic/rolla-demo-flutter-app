import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/repositories/score_repository.dart';

class GetEarliestScoreDate {
  final ScoreRepository repository;

  GetEarliestScoreDate({required this.repository});

  Future<Either<Failure, DateTime?>> call({
    DateTime? from,
    DateTime? to,
  }) async {
    return await repository.getEarliestScoreDate(from: from, to: to);
  }
}
