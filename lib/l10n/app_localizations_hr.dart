// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'Rolla Demo';

  @override
  String get settings => 'Postavke';

  @override
  String get language => 'Jezik';

  @override
  String get selectLanguage => 'Odaberi jezik';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Odaberi temu';

  @override
  String get themeModeSystem => 'Automatski (Sistem)';

  @override
  String get themeModeLight => 'Svijetla';

  @override
  String get themeModeDark => 'Tamna';

  @override
  String get logout => 'Odjava';

  @override
  String get homeTitle => 'Rezultati';

  @override
  String get health => 'Zdravlje';

  @override
  String get readiness => 'Spremnost';

  @override
  String get activity => 'Aktivnost';

  @override
  String get noData => 'Nema podataka';

  @override
  String get pullToRefresh => 'Povuci za osvježenje';

  @override
  String lastUpdated(Object date) {
    return 'Zadnje ažuriranje: $date';
  }

  @override
  String get exportPdf => 'Izvezi u PDF';

  @override
  String get timeframe1D => '1D';

  @override
  String get timeframe7D => '7D';

  @override
  String get timeframe30D => '30D';

  @override
  String get timeframe1Y => '1G';

  @override
  String get insightsTitle => 'Uvidi';

  @override
  String get metricAvg => 'Prosjek';
}
