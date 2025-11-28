import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/localization/localization_service.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/bloc/settings_cubit.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_select_dialog.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_text_input_dialog.dart';
import 'package:rolla_demo_app/features/scores/presentation/pages/init_page.dart';
import 'package:rolla_demo_app/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  // helper: mapping language code -> display name
  static const Map<String, String> _languageNames = {
    'en': 'English',
    'hr': 'Hrvatski',
  };

  Future<void> _showNameDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();

    final initialSettings = settingsCubit.settings;
    final initialName = initialSettings.name;

    final selectedName = await AppTextInputDialog.show(
      context: context,
      title: tr.enterName,
      initialValue: initialName,
      hintText: 'New name',
      maxLength: 40,
      allowEmpty: true,
      onChanged: (sel) => {},
      onCancel: () async => {},
      onAccept: (input) async {
        await settingsCubit.save(initialSettings.copyWith(name: input));
      },
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    final supported = S.delegate.supportedLocales;

    final initialSettings = settingsCubit.settings;
    final initialLocale = Locale(initialSettings.languageCode);

    final selectedLocale = await AppSelectDialog.show<Locale>(
      context: context,
      title: tr.selectLanguage,
      options: supported,
      initialSelected: initialLocale,
      optionLabel: (s) => _languageNames[s.languageCode]!,
      onSelectionChanged: (sel) => {},
      onCancel: () async => {},
      onAccept: (sel) async {
        await settingsCubit.save(
          initialSettings.copyWith(languageCode: sel?.languageCode),
        );
      },
    );
  }

  Future<void> _showThemeDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    final initialSettings = settingsCubit.settings;
    final initialTheme = initialSettings.themeMode;

    // helper: mapping theme mode -> display name
    Map<String, String> _themeNames = {};
    _themeNames[ThemeMode.system.name] = tr.themeModeSystem;
    _themeNames[ThemeMode.light.name] = tr.themeModeLight;
    _themeNames[ThemeMode.dark.name] = tr.themeModeDark;

    final selectedTheme = await AppSelectDialog.show<ThemeMode>(
      context: context,
      title: tr.selectTheme,
      options: ThemeMode.values,
      initialSelected: initialTheme,
      optionLabel: (s) => _themeNames[s.name]!,
      onSelectionChanged: (sel) async {
        await settingsCubit.save(initialSettings.copyWith(themeMode: sel));
      },
      onCancel: () async {
        await settingsCubit.save(initialSettings);
      },
      onAccept: (sel) async {
        await settingsCubit.save(initialSettings.copyWith(themeMode: sel));
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    await settingsCubit.save(settingsCubit.settings.copyWith(name: ''));

    // Push InitPage and clear everything else
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const InitPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (route) => false,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(tr.youHaveLoggedOut)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        Settings settings = state is SettingsLoaded
            ? state.settings
            : Settings.defaultSettings;
        ThemeMode themeMode = settings.themeMode;
        bool isLight = themeMode == ThemeMode.light;
        return Scaffold(
          appBar: AppBar(title: Text(tr.settings)),
          body: ListView(
            children: [
              ListTile(
                title: Text(tr.userName),
                subtitle: Text(settings.name ?? '-'),
                leading: const Icon(Icons.person),
                onTap: () => _showNameDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(tr.language),
                subtitle: Text(
                  _languageNames[LocalizationService
                              .instance
                              .currentLocale
                              ?.languageCode ??
                          'en'] ??
                      '',
                ),
                leading: const Icon(Icons.language),
                onTap: () => _showLanguageDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(tr.theme),
                subtitle: Text(
                  themeMode == ThemeMode.system
                      ? tr.themeModeSystem
                      : themeMode == ThemeMode.light
                      ? tr.themeModeLight
                      : tr.themeModeDark,
                ),
                leading: const Icon(Icons.brightness_6),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isLight ? Icons.light_mode : Icons.dark_mode),
                  ],
                ),
                onTap: () => _showThemeDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(tr.logout),
                leading: const Icon(Icons.logout),
                onTap: () => _logout(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
