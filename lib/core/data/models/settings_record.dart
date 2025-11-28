import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_record.freezed.dart';
part 'settings_record.g.dart';

@freezed
abstract class SettingsRecord with _$SettingsRecord {
  const factory SettingsRecord({
    required String? name,
    required String? languageCode,
    required String? themeMode,
  }) = _SettingsRecord;

  factory SettingsRecord.fromJson(Map<String, dynamic> json) =>
      _$SettingsRecordFromJson(json);
}
