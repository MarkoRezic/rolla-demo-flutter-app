import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rolla_demo_app/core/presentation/bloc/locale_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/settings_cubit.dart';
import 'package:rolla_demo_app/core/presentation/bloc/theme_cubit.dart';
import 'package:rolla_demo_app/features/scores/presentation/pages/init_page.dart';

import 'core/localization/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'features/scores/presentation/pages/home_page.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await di.initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: di.sl<LocaleCubit>()),
        BlocProvider.value(value: di.sl<ThemeCubit>()),
        BlocProvider.value(value: di.sl<SettingsCubit>()),
      ],
      child: const RollaApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class RollaApp extends StatefulWidget {
  const RollaApp({Key? key}) : super(key: key);

  @override
  State<RollaApp> createState() => _RollaAppState();
}

class _RollaAppState extends State<RollaApp> {
  late bool _nameInitialized = di.sl<SettingsCubit>().settings.name.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              title: 'Rolla Demo',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: locale,
              supportedLocales: LocalizationService.supportedLocales,
              localizationsDelegates: const [
                LocalizationService.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: _nameInitialized ? HomePage() : InitPage(),
            );
          },
        );
      },
    );
  }
}
