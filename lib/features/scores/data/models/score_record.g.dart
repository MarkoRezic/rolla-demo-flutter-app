// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreRecord _$ScoreRecordFromJson(Map<String, dynamic> json) => _ScoreRecord(
  id: (json['id'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  sleepMinutes: (json['sleepMinutes'] as num).toDouble(),
  restingHeartRateBpm: (json['restingHeartRateBpm'] as num).toDouble(),
  overnightHeartRateVarianceMs: (json['overnightHeartRateVarianceMs'] as num)
      .toDouble(),
  activePoints: (json['activePoints'] as num).toDouble(),
  steps: (json['steps'] as num).toDouble(),
  moveHours: (json['moveHours'] as num).toDouble(),
  activeCalories: (json['activeCalories'] as num).toDouble(),
  activities: (json['activities'] as List<dynamic>)
      .map((e) => ScoreActivityRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ScoreRecordToJson(_ScoreRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'sleepMinutes': instance.sleepMinutes,
      'restingHeartRateBpm': instance.restingHeartRateBpm,
      'overnightHeartRateVarianceMs': instance.overnightHeartRateVarianceMs,
      'activePoints': instance.activePoints,
      'steps': instance.steps,
      'moveHours': instance.moveHours,
      'activeCalories': instance.activeCalories,
      'activities': instance.activities,
    };
