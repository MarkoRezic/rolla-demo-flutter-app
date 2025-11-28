// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsRecord _$SettingsRecordFromJson(Map<String, dynamic> json) =>
    _SettingsRecord(
      name: json['name'] as String?,
      languageCode: json['languageCode'] as String?,
      themeMode: json['themeMode'] as String?,
    );

Map<String, dynamic> _$SettingsRecordToJson(_SettingsRecord instance) =>
    <String, dynamic>{
      'name': instance.name,
      'languageCode': instance.languageCode,
      'themeMode': instance.themeMode,
    };
