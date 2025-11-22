import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Outfit',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Outfit',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
  );

  // Accent colors per score type
  static Color accentFor(String type) {
    switch (type.toLowerCase()) {
      case 'health':
        return Colors.green.shade600;
      case 'readiness':
        return Colors.blue.shade600;
      case 'activity':
      default:
        return Colors.orange.shade600;
    }
  }
}
