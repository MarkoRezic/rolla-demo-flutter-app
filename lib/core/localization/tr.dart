import '../../generated/l10n.dart';
import 'localization_service.dart';

/// Global accessor for localized strings.
/// Use `tr.someKey` anywhere after localization has been loaded
/// (preferably load default locale at app startup).
///
/// If not yet loaded, this will return a fallback instance (the English
/// generated messages) if possible or throw a helpful error.
S get tr {
  final s = LocalizationService.instance.strings;
  if (s != null) return s;

  throw StateError(
    'Localization not initialized. Call LocalizationService.instance.load(locale) before using tr or ensure localization is loaded in main().',
  );
}
