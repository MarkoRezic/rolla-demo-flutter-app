import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Outfit',
    scaffoldBackgroundColor: AppColors.surfaceLight,
    colorScheme: ColorScheme.fromSeed(
      dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
      seedColor: AppColors.green,
      brightness: Brightness.light,
      surfaceTint: Colors.transparent,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black.withValues(alpha: 0.6),
      ),
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Outfit',
    colorScheme: ColorScheme.fromSeed(
      dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
      seedColor: AppColors.green,
      brightness: Brightness.dark,
      surfaceTint: Colors.transparent,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white.withValues(alpha: 0.6),
      ),
    ),
    useMaterial3: true,
  );

  // Color that is commonly used for dividers, grid lines, borders - adapts to theme
  static Color lightGrey(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1);

  // Accent colors per score type
  static Color accentFor(String type) {
    switch (type.toLowerCase()) {
      case 'activity':
        return AppColors.green;
      case 'readiness':
        return AppColors.purple;
      case 'health':
        return AppColors.blue;
      default:
        return AppColors.black;
    }
  }
}
