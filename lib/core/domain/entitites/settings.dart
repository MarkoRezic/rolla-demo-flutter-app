import 'package:flutter/material.dart';

@immutable
class Settings {

  const Settings({
    required this.name,
    required this.languageCode,
    required this.themeMode,
  });
  final String name;
  final String languageCode;
  final ThemeMode themeMode;

  Settings copyWith({
    String? name,
    String? languageCode,
    ThemeMode? themeMode,
  }) {
    return Settings(
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  static const Settings defaultSettings = Settings(
    name: '',
    languageCode: 'en',
    themeMode: ThemeMode.system,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Settings &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          languageCode == other.languageCode &&
          themeMode == other.themeMode;

  @override
  int get hashCode => Object.hash(name, languageCode, themeMode);
}
