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
  String get healthScore => 'Rezultat Zdravlja';

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
}
