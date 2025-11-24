import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/repositories/score_repository.dart';

class GetScores {
  final ScoreRepository repository;

  GetScores({required this.repository});

  Future<Either<Failure, List<Score>>> call({
    DateTime? from,
    DateTime? to,
  }) async {
    return await repository.getScores(from: from, to: to);
  }
}
