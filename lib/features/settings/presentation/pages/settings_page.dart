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
  const SettingsPage({super.key});

  // helper: mapping language code -> display name
  static const Map<String, String> _languageNames = <String, String>{
    'en': 'English',
    'hr': 'Hrvatski',
  };

  Future<void> _showNameDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();

    final Settings initialSettings = settingsCubit.settings;
    final String initialName = initialSettings.name;

    await AppTextInputDialog.show(
      context: context,
      title: tr.enterName,
      initialValue: initialName,
      hintText: 'New name',
      maxLength: 40,
      allowEmpty: true,
      onChanged: (String sel) => <dynamic, dynamic>{},
      onCancel: () async => <dynamic, dynamic>{},
      onAccept: (String input) async {
        await settingsCubit.save(initialSettings.copyWith(name: input));
      },
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    final List<Locale> supported = S.delegate.supportedLocales;

    final Settings initialSettings = settingsCubit.settings;
    final Locale initialLocale = Locale(initialSettings.languageCode);

    await AppSelectDialog.show<Locale>(
      context: context,
      title: tr.selectLanguage,
      options: supported,
      initialSelected: initialLocale,
      optionLabel: (Locale s) => _languageNames[s.languageCode]!,
      onSelectionChanged: (Locale? sel) => <dynamic, dynamic>{},
      onCancel: () async => <dynamic, dynamic>{},
      onAccept: (Locale? sel) async {
        await settingsCubit.save(
          initialSettings.copyWith(languageCode: sel?.languageCode),
        );
      },
    );
  }

  Future<void> _showThemeDialog(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();
    final Settings initialSettings = settingsCubit.settings;
    final ThemeMode initialTheme = initialSettings.themeMode;

    // helper: mapping theme mode -> display name
    final Map<String, String> themeNames = <String, String>{};
    themeNames[ThemeMode.system.name] = tr.themeModeSystem;
    themeNames[ThemeMode.light.name] = tr.themeModeLight;
    themeNames[ThemeMode.dark.name] = tr.themeModeDark;

    await AppSelectDialog.show<ThemeMode>(
      context: context,
      title: tr.selectTheme,
      options: ThemeMode.values,
      initialSelected: initialTheme,
      optionLabel: (ThemeMode s) => themeNames[s.name]!,
      onSelectionChanged: (ThemeMode? sel) async {
        await settingsCubit.save(initialSettings.copyWith(themeMode: sel));
      },
      onCancel: () async {
        await settingsCubit.save(initialSettings);
      },
      onAccept: (ThemeMode? sel) async {
        await settingsCubit.save(initialSettings.copyWith(themeMode: sel));
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final SettingsCubit settingsCubit = GetIt.instance<SettingsCubit>();

    // Capture NavigatorState and ScaffoldMessengerState before the async work:
    final NavigatorState navigator = Navigator.of(context);
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    await settingsCubit.save(settingsCubit.settings.copyWith(name: ''));

    // Use the captured objects (not the BuildContext).
    navigator.pushAndRemoveUntil(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const InitPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (Route<dynamic> route) => false,
    );

    messenger.showSnackBar(SnackBar(content: Text(tr.youHaveLoggedOut)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        final Settings settings = state is SettingsLoaded
            ? state.settings
            : Settings.defaultSettings;
        final ThemeMode themeMode = settings.themeMode;
        final bool isLight = themeMode == ThemeMode.light;
        return Scaffold(
          appBar: AppBar(title: Text(tr.settings)),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: Text(tr.userName),
                subtitle: Text(settings.name),
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
                  children: <Widget>[
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
