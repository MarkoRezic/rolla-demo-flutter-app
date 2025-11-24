import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/localization/localization_service.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/bloc/locale_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/theme_cubit.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_select_dialog.dart';
import 'package:rolla_demo_app/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  // helper: mapping language code -> display name
  static const Map<String, String> _languageNames = {
    'en': 'English',
    'hr': 'Hrvatski',
  };

  Future<void> _showLanguageDialog(
    BuildContext context,
    LocaleCubit localeCubit,
  ) async {
    final supported = S.delegate.supportedLocales;
    final initialLocale = localeCubit.state;

    final selectedLocale = await AppSelectDialog.show<Locale>(
      context: context,
      title: tr.selectLanguage,
      options: supported,
      initialSelected: initialLocale,
      optionLabel: (s) => _languageNames[s.languageCode]!,
      onSelectionChanged: (sel) => {},
      onCancel: () async => {await localeCubit.setLocale(initialLocale)},
      onAccept: (sel) async => {
        await localeCubit.setLocale(sel ?? initialLocale),
      },
    );
  }

  Future<void> _showThemeDialog(
    BuildContext context,
    ThemeCubit themeCubit,
  ) async {
    final initialTheme = themeCubit.state;

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
      onSelectionChanged: (sel) => {themeCubit.setTheme(sel ?? initialTheme)},
      onCancel: () => themeCubit.setTheme(initialTheme),
      onAccept: (sel) => {themeCubit.setTheme(sel ?? initialTheme)},
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(tr.settings)),
      body: ListView(
        children: [
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
            onTap: () => _showLanguageDialog(context, localeCubit),
          ),
          const Divider(height: 1),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isLight = themeMode == ThemeMode.light;
              return ListTile(
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
                onTap: () => _showThemeDialog(context, themeCubit),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: Text(
              tr.logout,
            ), // here using an existing key - replace if you have "logout"
            leading: const Icon(Icons.logout),
            onTap: () {
              // Logout intentionally no-op; show a message to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout action not implemented yet')),
              );
            },
          ),
        ],
      ),
    );
  }
}
