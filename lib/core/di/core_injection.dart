import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/data/datasources/shared_prefs_datasource.dart';
import 'package:rolla_demo_app/core/data/repositories/settings_repository_impl.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/domain/usecases/get_settings.dart';
import 'package:rolla_demo_app/core/domain/usecases/save_settings.dart';
import 'package:rolla_demo_app/core/localization/localization_service.dart';
import 'package:rolla_demo_app/core/presentation/bloc/locale_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/settings_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initCore(GetIt sl) async {
  // Data sources
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPrefsDataSource>(
    () => SharedPrefsDataSource(_prefs),
  );
  // Repositories
  sl.registerLazySingleton<SettingsRepositoryImpl>(
    () => SettingsRepositoryImpl(dataSource: sl<SharedPrefsDataSource>()),
  );
  // Use Cases
  final getSettings = GetSettings(repository: sl<SettingsRepositoryImpl>());
  final saveSettings = SaveSettings(repository: sl<SettingsRepositoryImpl>());
  // Blocs (singletons since these are core)
  sl.registerLazySingleton(
    () => SettingsCubit(getSettings: getSettings, saveSettings: saveSettings),
  );

  await sl<SettingsCubit>().fetchOnce();
  Settings initialSettings = sl<SettingsCubit>().settings;

  Locale initialLocale = Locale(initialSettings.languageCode);
  ThemeMode initialThemeMode = initialSettings.themeMode;

  await LocalizationService.instance.load(initialLocale);

  sl.registerLazySingleton(() => LocaleCubit(initialLocale));
  sl.registerLazySingleton(() => ThemeCubit(initialThemeMode));
}
