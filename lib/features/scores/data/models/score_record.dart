import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_record.freezed.dart';
part 'score_record.g.dart';

@freezed
abstract class ScoreRecord with _$ScoreRecord {
  const factory ScoreRecord({
    required String id,
    required String type,
    required DateTime timestamp,
    required int score,
    required Map<String, dynamic> metrics,
  }) = _ScoreRecord;

  factory ScoreRecord.fromJson(Map<String, dynamic> json) =>
      _$ScoreRecordFromJson(json);
}
