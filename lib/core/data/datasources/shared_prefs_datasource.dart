import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/data/models/settings_record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDataSource {
  SharedPrefsDataSource(this._prefs);
  static const String _kName = 'name';
  static const String _kLanguageCode = 'languageCode';
  static const String _kThemeMode = 'themeMode';

  final SharedPreferences _prefs;

  Future<SettingsRecord> getAll() async {
    final String name = getName();
    final String languageCode = getLanguageCode();
    final String themeMode = getThemeMode();

    return SettingsRecord.fromJson(<String, dynamic>{
      _kName: name,
      _kLanguageCode: languageCode,
      _kThemeMode: themeMode,
    });
  }

  Future<void> saveAll({
    required String name,
    required String language,
    required String theme,
  }) async {
    await _prefs.setString(_kName, name);
    await _prefs.setString(_kLanguageCode, language);
    await _prefs.setString(_kThemeMode, theme);
  }

  String getName() => _prefs.getString(_kName) ?? '';

  String getLanguageCode() => _prefs.getString(_kLanguageCode) ?? 'en';

  String getThemeMode() =>
      _prefs.getString(_kThemeMode) ?? ThemeMode.system.name;
}
