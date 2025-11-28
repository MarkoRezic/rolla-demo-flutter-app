import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/data/datasources/shared_prefs_datasource.dart';
import 'package:rolla_demo_app/core/data/models/settings_record.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/domain/repositories/settings_repository.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/extensions/list/list_first_where_or_null.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPrefsDataSource dataSource;

  SettingsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    try {
      final settings = await dataSource.getAll();

      return right(_mapScoreRecordToDomain(settings));
    } catch (e, st) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Settings>> saveSettings(Settings settings) async {
    try {
      await dataSource.saveAll(
        name: settings.name,
        language: settings.languageCode,
        theme: settings.themeMode.name,
      );

      return right(settings);
    } catch (e, st) {
      return left(Failure(e.toString()));
    }
  }

  Settings _mapScoreRecordToDomain(SettingsRecord r) {
    return Settings.defaultSettings.copyWith(
      name: r.name,
      languageCode: r.languageCode,
      themeMode: r.themeMode == null
          ? null
          : ThemeMode.values.firstWhereOrNull(
              (mode) => mode.name == r.themeMode,
            ),
    );
  }
}
