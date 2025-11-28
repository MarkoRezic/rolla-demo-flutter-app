import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/localization/localization_service.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(Locale initial) : super(initial) {
    LocalizationService.instance.load(initial);
  }

  Future<void> setLocale(Locale locale) async {
    // load localization resources (updates LocalizationService.instance.strings)
    await LocalizationService.instance.load(locale);
    emit(locale); // listeners will rebuild
  }
}
