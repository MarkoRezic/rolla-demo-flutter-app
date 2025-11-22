// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreRecord _$ScoreRecordFromJson(Map<String, dynamic> json) => _ScoreRecord(
  id: json['id'] as String,
  type: json['type'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  score: (json['score'] as num).toInt(),
  metrics: json['metrics'] as Map<String, dynamic>,
);

Map<String, dynamic> _$ScoreRecordToJson(_ScoreRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'score': instance.score,
      'metrics': instance.metrics,
    };
