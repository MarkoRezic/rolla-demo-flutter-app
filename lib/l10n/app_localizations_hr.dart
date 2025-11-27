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
  String get error => 'Greška';

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
  String get history => 'Povijest';

  @override
  String get health => 'Zdravlje';

  @override
  String get healthScore => 'Rezultat Zdravlja';

  @override
  String get readiness => 'Spremnost';

  @override
  String get readinessScore => 'Rezultat Spremnosti';

  @override
  String get activity => 'Aktivnost';

  @override
  String get activityScore => 'Rezultat Aktivnosti';

  @override
  String get activePoints => 'Aktivni bodovi';

  @override
  String get steps => 'Koraci';

  @override
  String get moveHours => 'Sati kretanja';

  @override
  String get activeCalories => 'Aktivne kalorije';

  @override
  String get sleep => 'Spavanje';

  @override
  String get restingHR => 'Otkucaji u mirovanju';

  @override
  String get overnightHRV => 'Noćni HRV';

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
  String get monthly => 'Mjesečni';

  @override
  String get insightsTitle => 'Uvidi';

  @override
  String get metrics => 'Metrike';

  @override
  String timeframeAvg(String timeframe) {
    String _temp0 = intl.Intl.selectLogic(timeframe, {
      'day': '',
      'week': 'Dnevni Prosjek',
      'month': 'Dnevni Prosjek',
      'year': 'Dnevni Prosjek',
      'yearMonthly': 'Mjesečni Prosjek',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get about => 'About';

  @override
  String get howItWorks => 'How It Works?';

  @override
  String get scoreDescriptionActivity =>
      'Vaš rezultat aktivnosti mjeri koliko ste se kretali tijekom dana i koliko je vaša aktivnost bila dosljedna. Gleda korake, aktivne bodove i sate pokreta kako bi obuhvatio i napor i učestalost.\n\nRezultat 80 predstavlja vašu osobnu osnovicu — vašu uobičajenu dnevnu aktivnost tijekom posljednjih 30 dana. Viši rezultati znače da ste premašili uobičajeni tempo ili intenzitet. Niži rezultati pokazuju blaže kretanje ili više odmora nego inače.\n\nKoristite ovaj rezultat kao motivaciju da ostanete aktivni na uravnotežen način.';

  @override
  String get scoreDescriptionReadiness =>
      'Vaš rezultat spremnosti pokazuje koliko se vaše tijelo oporavilo i koliko ste danas spremni za nastup/aktivnost. Temelji se na vašem snu, pulsu u mirovanju i varijabilnosti otkucaja srca.\n\nRezultat 80 je vaša osobna osnovica. To je točka u kojoj se vaše tijelo osjeća uravnoteženo i spremno za normalan dan. Viši rezultati znače da ste napunjeni energijom i spremni za aktivnost. Niži rezultati sugeriraju da vaše tijelo treba više odmora, kvalitetniji san ili lakše kretanje.\n\nSmatrajte ovaj rezultat svojom dnevnom provjerom. Kad je rezultat visok, trebali biste se osjećati energičnije i motiviranije da budete produktivni tog dana.';

  @override
  String get scoreDescriptionHealth =>
      'Vaš rezultat zdravlja spaja odmor i aktivnost u jedan broj, pokazujući koliko je vaš dan uravnotežen. To je prosjek vaših rezultata spremnosti i aktivnosti.\n\nRezultat 80 predstavlja vašu osobnu osnovicu. To je točka u kojoj se vaši dnevni pokazatelji slažu s vašim 30-dnevnim prosjecima. Pređete li 80, radite iznad uobičajenog. Ako padnete ispod 80, provjerite koja područja vašeg zdravlja trebaju više pažnje.';

  @override
  String get scoreMetricsDescriptionActivity =>
      'Vaš rezultat aktivnosti mjeri koliko ste se kretali tijekom dana i koliko je vaša aktivnost bila dosljedna. Gleda korake, aktivne bodove i sate pokreta kako bi obuhvatio i napor i učestalost.\n\nRezultat 80 predstavlja vašu osobnu osnovicu — vašu uobičajenu dnevnu aktivnost tijekom posljednjih 30 dana. Viši rezultati znače da ste premašili uobičajeni tempo ili intenzitet. Niži rezultati pokazuju blaže kretanje ili više odmora nego inače.\n\nKoristite ovaj rezultat kao motivaciju da ostanete aktivni na uravnotežen način.';

  @override
  String get scoreMetricsDescriptionReadiness =>
      'Vaš rezultat spremnosti pokazuje koliko se vaše tijelo oporavilo i koliko ste danas spremni za nastup/aktivnost. Temelji se na vašem snu, pulsu u mirovanju i varijabilnosti otkucaja srca.\n\nRezultat 80 je vaša osobna osnovica. To je točka u kojoj se vaše tijelo osjeća uravnoteženo i spremno za normalan dan. Viši rezultati znače da ste napunjeni energijom i spremni za aktivnost. Niži rezultati sugeriraju da vaše tijelo treba više odmora, kvalitetniji san ili lakše kretanje.\n\nSmatrajte ovaj rezultat svojom dnevnom provjerom. Kad je rezultat visok, trebali biste se osjećati energičnije i motiviranije da budete produktivni tog dana.';

  @override
  String get scoreMetricsDescriptionHealth =>
      'Vaš rezultat zdravlja spaja odmor i aktivnost u jedan broj, pokazujući koliko je vaš dan uravnotežen. To je prosjek vaših rezultata spremnosti i aktivnosti.\n\nRezultat 80 predstavlja vašu osobnu osnovicu. To je točka u kojoj se vaši dnevni pokazatelji slažu s vašim 30-dnevnim prosjecima. Pređete li 80, radite iznad uobičajenog. Ako padnete ispod 80, provjerite koja područja vašeg zdravlja trebaju više pažnje.';

  @override
  String get insightInsufficientData =>
      'Nema dovoljno podataka za davanje uvida.';

  @override
  String insightBetterThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric je veći nego $period: $value ($change% ↑).';
  }

  @override
  String insightWorseThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric je manji nego $period: $value ($change% ↓).';
  }

  @override
  String insightNoChangeSincePreviousPeriod(
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric je otprilike isti kao $period: $value.';
  }

  @override
  String insightBigImprovement(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric pokazuje značajno poboljšanje u odnosu na $period: $value (+$change%).';
  }

  @override
  String insightBigDrop(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric je značajno pao u odnosu na $period: $value ($change%).';
  }

  @override
  String insightUpwardTrend(Object metric) {
    return '$metric pokazuje uzlazni trend u odabranom razdoblju.';
  }

  @override
  String insightDownwardTrend(Object metric) {
    return '$metric pokazuje silazni trend u odabranom razdoblju.';
  }

  @override
  String insightStableTrend(Object metric) {
    return '$metric je konzistentan u odabranom razdoblju.';
  }

  @override
  String insightHighVariability(Object metric, Object sd) {
    return '$metric mnogo varira.';
  }

  @override
  String insightLowVariability(Object metric) {
    return '$metric je jako konzistentan.';
  }

  @override
  String insightTargetMet(Object metric, Object value) {
    return '$metric dostiže cilj: $value.';
  }

  @override
  String insightTargetNotMet(Object metric, Object value) {
    return '$metric ne dostiže cilj: $value.';
  }

  @override
  String insightSleepInTarget(Object value) {
    return 'Trajanje sna je u zdravom rasponu: $value.';
  }

  @override
  String insightSleepTooShort(Object value) {
    return 'Trajanje sna je ispod zdravog raspona: $value.';
  }

  @override
  String insightSleepTooLong(Object value) {
    return 'Trajanje sna je iznad zdravog raspona: $value.';
  }

  @override
  String get periodYesterday => 'jučer';

  @override
  String get periodLastWeek => 'prošli tjedan';

  @override
  String get periodLastMonth => 'prošli mjesec';

  @override
  String get periodLastYear => 'prošle godine';

  @override
  String get plusInfinity => '—';

  @override
  String get valueUnitPts => 'bod';

  @override
  String get valueUnitH => 'h';

  @override
  String get valueUnitBpm => 'bpm';

  @override
  String get valueUnitMs => 'ms';

  @override
  String get valueUnitSteps => 'koraka';

  @override
  String get valueUnitKcal => 'kcal';
}
