// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rolla Demo';

  @override
  String get homeTitle => 'Scores';

  @override
  String get health => 'Health';

  @override
  String get readiness => 'Readiness';

  @override
  String get activity => 'Activity';

  @override
  String get noData => 'No data';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String lastUpdated(Object date) {
    return 'Last updated: $date';
  }

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get timeframe1D => '1D';

  @override
  String get timeframe7D => '7D';

  @override
  String get timeframe30D => '30D';

  @override
  String get timeframe1Y => '1Y';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get metricAvg => 'Avg';
}
