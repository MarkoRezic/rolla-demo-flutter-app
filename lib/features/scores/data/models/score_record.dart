import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rolla_demo_app/features/scores/data/models/score_activity_record.dart';

part 'score_record.freezed.dart';
part 'score_record.g.dart';

@freezed
abstract class ScoreRecord with _$ScoreRecord {
  const factory ScoreRecord({
    required int id,
    required DateTime date,
    required double sleepMinutes,
    required double restingHeartRateBpm,
    required double overnightHeartRateVarianceMs,
    required double activePoints,
    required double steps,
    required double moveHours,
    required double activeCalories,
    required List<ScoreActivityRecord> activities,
  }) = _ScoreRecord;

  factory ScoreRecord.fromJson(Map<String, dynamic> json) =>
      _$ScoreRecordFromJson(json);
}
