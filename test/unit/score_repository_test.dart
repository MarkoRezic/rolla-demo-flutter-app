import 'package:flutter_test/flutter_test.dart';
import 'package:rolla_demo_app/core/utils/date_time_utils.dart';
import 'package:rolla_demo_app/features/scores/data/datasources/local_json_datasource.dart';
import 'package:rolla_demo_app/features/scores/data/repositories/score_repository_impl.dart';

void main() {
  test('Load scores from local json and filter', () async {
    final ds = LocalJsonDataSource(assetPath: 'assets/data/scores.json');
    final repo = ScoreRepositoryImpl(dataSource: ds);

    final fromDate = startOfCurrentDay().subtract(Duration(days: 30));
    final res = await repo.getScores(from: fromDate);
    expect(res.isRight(), true);
    res.fold((l) => fail('should not fail: ${l.message}'), (list) {
      expect(list.every((r) => r.date.isAfter(fromDate)), true);
    });
  });
}
