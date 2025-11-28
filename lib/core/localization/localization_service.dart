import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/generated/l10n.dart';

class LocalizationService {
  LocalizationService._();
  static final LocalizationService instance = LocalizationService._();

  static const AppLocalizationDelegate delegate = S.delegate;
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('hr')];

  S? _strings;
  Locale? _locale;

  S? get strings => _strings;
  Locale? get currentLocale => _locale;

  Future<void> load(Locale locale) async {
    Intl.defaultLocale = locale.toLanguageTag();
    _strings = await S.delegate.load(locale);
    _locale = locale;
  }

  static void setLocale(Locale locale) {
    Intl.defaultLocale = locale.languageCode;
  }
}
