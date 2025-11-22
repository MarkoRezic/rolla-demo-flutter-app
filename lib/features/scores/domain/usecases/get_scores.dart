import 'package:dartz/dartz.dart';

import '../../data/repositories/score_repository_impl.dart';
import '../entities/score.dart';

class GetScores {
  final ScoreRepositoryImpl repository;

  GetScores({required this.repository});

  Future<Either<Failure, List<Score>>> call({
    String? type,
    DateTime? from,
    DateTime? to,
  }) async {
    final res = await repository.getScores(type: type, from: from, to: to);
    return res.fold((l) => left(l), (records) {
      final list = records
          .map((r) => Score(
                id: r.id,
                type: r.type,
                timestamp: r.timestamp,
                score: r.score,
                metrics: r.metrics,
              ))
          .toList();
      return right(list);
    });
  }
}
