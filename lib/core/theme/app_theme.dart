import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class AppTheme {
  static final lightColorScheme = ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
    seedColor: AppColors.green,
    brightness: Brightness.light,
    surfaceTint: Colors.transparent,
  );
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Outfit',
    colorScheme: lightColorScheme,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        color: lightColorScheme.onSurface.withValues(alpha: 0.6),
      ),
    ),
    useMaterial3: true,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
    seedColor: AppColors.green,
    brightness: Brightness.dark,
    surfaceTint: Colors.transparent,
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Outfit',
    colorScheme: darkColorScheme,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        color: darkColorScheme.onSurface.withValues(alpha: 0.6),
      ),
    ),
    useMaterial3: true,
  );

  // Color that is commonly used for dividers, grid lines, borders - adapts to theme
  static Color lightGrey(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1);

  static Color shimmerBase(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color shimmerHighlight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? Theme.of(context).colorScheme.surfaceContainer
      : Theme.of(context).colorScheme.surfaceContainerHigh;
}
