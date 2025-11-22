import 'package:flutter_test/flutter_test.dart';
import 'package:rolla_demo_app/features/scores/data/datasources/local_json_datasource.dart';
import 'package:rolla_demo_app/features/scores/data/repositories/score_repository_impl.dart';

void main() {
  test('Load scores from local json and filter', () async {
    final ds = LocalJsonDataSource(assetPath: 'assets/data/scores.json');
    final repo = ScoreRepositoryImpl(dataSource: ds);

    final res = await repo.getScores(type: 'activity');
    expect(res.isRight(), true);
    res.fold((l) => fail('should not fail: ${l.message}'), (list) {
      expect(
          list.every((r) =>
              r.type == 'activity' ||
              r.type == 'Activity' ||
              r.type == 'ACTIVITY'),
          true);
    });
  });
}
