import 'package:dartz/dartz.dart';

import '../../domain/entities/score.dart';
import '../datasources/local_json_datasource.dart';
import '../models/score_record.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class ScoreRepositoryImpl {
  final LocalJsonDataSource dataSource;

  ScoreRepositoryImpl({required this.dataSource});

  Future<Either<Failure, List<ScoreRecord>>> getScores(
      {String? type, DateTime? from, DateTime? to}) async {
    try {
      final all = await dataSource.loadAll();
      final filtered = all.where((r) {
        final byType =
            type == null || r.type.toLowerCase() == type.toLowerCase();
        final byFrom = from == null ||
            r.timestamp.isAfter(from) ||
            r.timestamp.isAtSameMomentAs(from);
        final byTo = to == null ||
            r.timestamp.isBefore(to) ||
            r.timestamp.isAtSameMomentAs(to);
        return byType && byFrom && byTo;
      }).toList();
      return right(filtered);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
