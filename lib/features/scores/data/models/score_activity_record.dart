import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_activity_record.freezed.dart';
part 'score_activity_record.g.dart';

@freezed
abstract class ScoreActivityRecord with _$ScoreActivityRecord {
  const factory ScoreActivityRecord({
    required int id,
    required String category,
    required double durationSeconds,
    required double calories,
  }) = _ScoreActivityRecord;

  factory ScoreActivityRecord.fromJson(Map<String, dynamic> json) =>
      _$ScoreActivityRecordFromJson(json);
}
