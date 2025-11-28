import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/domain/usecases/get_settings.dart';
import 'package:rolla_demo_app/core/domain/usecases/save_settings.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/core/presentation/bloc/locale_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/theme_cubit.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  Settings? _cachedSettings;
  bool _hasFetched = false;

  SettingsCubit({
    required GetSettings getSettings,
    required SaveSettings saveSettings,
  }) : _saveSettings = saveSettings,
       _getSettings = getSettings,
       super(SettingsLoaded(Settings.defaultSettings));

  Future<void> fetchOnce() async {
    if (_hasFetched) {
      if (_cachedSettings != null) {
        emit(SettingsLoaded(_cachedSettings!));
      }
      return;
    }

    _hasFetched = true;
    emit(SettingsLoading());

    final Either<Failure, Settings> res = await _getSettings();

    res.fold(
      (failure) {
        emit(SettingsError(failure.message));
      },
      (settings) {
        _cachedSettings = settings;
        emit(SettingsLoaded(settings));
      },
    );
  }

  Future<void> save(Settings settings) async {
    final Either<Failure, Settings> res = await _saveSettings(
      settings: settings,
    );

    res.fold(
      (failure) {
        emit(SettingsError(failure.message));
      },
      (settings) async {
        _hasFetched = true;
        _cachedSettings = settings;
        await GetIt.instance<LocaleCubit>().setLocale(
          Locale(settings.languageCode),
        );
        GetIt.instance<ThemeCubit>().setTheme(settings.themeMode);
        emit(SettingsLoaded(settings));
      },
    );
  }

  void invalidateCache() {
    _cachedSettings = null;
    _hasFetched = false;
    emit(SettingsLoaded(Settings.defaultSettings));
  }

  Settings get settings => _cachedSettings ?? Settings.defaultSettings;
}
