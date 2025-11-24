// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_activity_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreActivityRecord _$ScoreActivityRecordFromJson(Map<String, dynamic> json) =>
    _ScoreActivityRecord(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      durationSeconds: (json['durationSeconds'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
    );

Map<String, dynamic> _$ScoreActivityRecordToJson(
  _ScoreActivityRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'durationSeconds': instance.durationSeconds,
  'calories': instance.calories,
};
