// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hr';

  static String m0(metric, period, value, change) =>
      "${metric} je veći nego ${period}: ${value} (${change}% ↑).";

  static String m1(metric, period, value, change) =>
      "${metric} je značajno pao u odnosu na ${period}: ${value} (${change}%).";

  static String m2(metric, period, value, change) =>
      "${metric} pokazuje značajno poboljšanje u odnosu na ${period}: ${value} (+${change}%).";

  static String m3(metric) =>
      "${metric} pokazuje silazni trend u odabranom razdoblju.";

  static String m4(metric, sd) => "${metric} mnogo varira.";

  static String m5(metric) => "${metric} je jako konzistentan.";

  static String m6(metric, period, value) =>
      "${metric} je otprilike isti kao ${period}: ${value}.";

  static String m7(value) => "Trajanje sna je u zdravom rasponu: ${value}.";

  static String m8(value) => "Trajanje sna je iznad zdravog raspona: ${value}.";

  static String m9(value) => "Trajanje sna je ispod zdravog raspona: ${value}.";

  static String m10(metric) =>
      "${metric} je konzistentan u odabranom razdoblju.";

  static String m11(metric, value) => "${metric} dostiže cilj: ${value}.";

  static String m12(metric, value) => "${metric} ne dostiže cilj: ${value}.";

  static String m13(metric) =>
      "${metric} pokazuje uzlazni trend u odabranom razdoblju.";

  static String m14(metric, period, value, change) =>
      "${metric} je manji nego ${period}: ${value} (${change}% ↓).";

  static String m15(date) => "Zadnje ažuriranje: ${date}";

  static String m16(timeframe) =>
      "${Intl.select(timeframe, {'day': '', 'week': 'Dnevni Prosjek', 'month': 'Dnevni Prosjek', 'year': 'Dnevni Prosjek', 'yearMonthly': 'Mjesečni Prosjek', 'other': ''})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "activeCalories": MessageLookupByLibrary.simpleMessage("Aktivne kalorije"),
    "activePoints": MessageLookupByLibrary.simpleMessage("Aktivni bodovi"),
    "activity": MessageLookupByLibrary.simpleMessage("Aktivnost"),
    "activityScore": MessageLookupByLibrary.simpleMessage(
      "Rezultat Aktivnosti",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Rolla Demo"),
    "error": MessageLookupByLibrary.simpleMessage("Greška"),
    "exportPdf": MessageLookupByLibrary.simpleMessage("Izvezi u PDF"),
    "health": MessageLookupByLibrary.simpleMessage("Zdravlje"),
    "healthScore": MessageLookupByLibrary.simpleMessage("Rezultat Zdravlja"),
    "history": MessageLookupByLibrary.simpleMessage("Povijest"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Rezultati"),
    "howItWorks": MessageLookupByLibrary.simpleMessage("How It Works?"),
    "insightBetterThanPreviousPeriod": m0,
    "insightBigDrop": m1,
    "insightBigImprovement": m2,
    "insightDownwardTrend": m3,
    "insightHighVariability": m4,
    "insightInsufficientData": MessageLookupByLibrary.simpleMessage(
      "Nema dovoljno podataka za davanje uvida.",
    ),
    "insightLowVariability": m5,
    "insightNoChangeSincePreviousPeriod": m6,
    "insightSleepInTarget": m7,
    "insightSleepTooLong": m8,
    "insightSleepTooShort": m9,
    "insightStableTrend": m10,
    "insightTargetMet": m11,
    "insightTargetNotMet": m12,
    "insightUpwardTrend": m13,
    "insightWorseThanPreviousPeriod": m14,
    "insightsTitle": MessageLookupByLibrary.simpleMessage("Uvidi"),
    "language": MessageLookupByLibrary.simpleMessage("Jezik"),
    "lastUpdated": m15,
    "logout": MessageLookupByLibrary.simpleMessage("Odjava"),
    "metrics": MessageLookupByLibrary.simpleMessage("Metrike"),
    "monthly": MessageLookupByLibrary.simpleMessage("Mjesečni"),
    "moveHours": MessageLookupByLibrary.simpleMessage("Sati kretanja"),
    "noData": MessageLookupByLibrary.simpleMessage("Nema podataka"),
    "overnightHRV": MessageLookupByLibrary.simpleMessage("Noćni HRV"),
    "periodLastMonth": MessageLookupByLibrary.simpleMessage("prošli mjesec"),
    "periodLastWeek": MessageLookupByLibrary.simpleMessage("prošli tjedan"),
    "periodLastYear": MessageLookupByLibrary.simpleMessage("prošle godine"),
    "periodYesterday": MessageLookupByLibrary.simpleMessage("jučer"),
    "plusInfinity": MessageLookupByLibrary.simpleMessage("—"),
    "pullToRefresh": MessageLookupByLibrary.simpleMessage(
      "Povuci za osvježenje",
    ),
    "readiness": MessageLookupByLibrary.simpleMessage("Spremnost"),
    "readinessScore": MessageLookupByLibrary.simpleMessage(
      "Rezultat Spremnosti",
    ),
    "restingHR": MessageLookupByLibrary.simpleMessage("Otkucaji u mirovanju"),
    "scoreDescriptionActivity": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat aktivnosti mjeri koliko ste se kretali tijekom dana i koliko je vaša aktivnost bila dosljedna. Gleda korake, aktivne bodove i sate pokreta kako bi obuhvatio i napor i učestalost.\n\nRezultat 80 predstavlja vašu osobnu osnovicu — vašu uobičajenu dnevnu aktivnost tijekom posljednjih 30 dana. Viši rezultati znače da ste premašili uobičajeni tempo ili intenzitet. Niži rezultati pokazuju blaže kretanje ili više odmora nego inače.\n\nKoristite ovaj rezultat kao motivaciju da ostanete aktivni na uravnotežen način.",
    ),
    "scoreDescriptionHealth": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat zdravlja spaja odmor i aktivnost u jedan broj, pokazujući koliko je vaš dan uravnotežen. To je prosjek vaših rezultata spremnosti i aktivnosti.\n\nRezultat 80 predstavlja vašu osobnu osnovicu. To je točka u kojoj se vaši dnevni pokazatelji slažu s vašim 30-dnevnim prosjecima. Pređete li 80, radite iznad uobičajenog. Ako padnete ispod 80, provjerite koja područja vašeg zdravlja trebaju više pažnje.",
    ),
    "scoreDescriptionReadiness": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat spremnosti pokazuje koliko se vaše tijelo oporavilo i koliko ste danas spremni za nastup/aktivnost. Temelji se na vašem snu, pulsu u mirovanju i varijabilnosti otkucaja srca.\n\nRezultat 80 je vaša osobna osnovica. To je točka u kojoj se vaše tijelo osjeća uravnoteženo i spremno za normalan dan. Viši rezultati znače da ste napunjeni energijom i spremni za aktivnost. Niži rezultati sugeriraju da vaše tijelo treba više odmora, kvalitetniji san ili lakše kretanje.\n\nSmatrajte ovaj rezultat svojom dnevnom provjerom. Kad je rezultat visok, trebali biste se osjećati energičnije i motiviranije da budete produktivni tog dana.",
    ),
    "scoreMetricsDescriptionActivity": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat aktivnosti mjeri koliko ste se kretali tijekom dana i koliko je vaša aktivnost bila dosljedna. Gleda korake, aktivne bodove i sate pokreta kako bi obuhvatio i napor i učestalost.\n\nRezultat 80 predstavlja vašu osobnu osnovicu — vašu uobičajenu dnevnu aktivnost tijekom posljednjih 30 dana. Viši rezultati znače da ste premašili uobičajeni tempo ili intenzitet. Niži rezultati pokazuju blaže kretanje ili više odmora nego inače.\n\nKoristite ovaj rezultat kao motivaciju da ostanete aktivni na uravnotežen način.",
    ),
    "scoreMetricsDescriptionHealth": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat zdravlja spaja odmor i aktivnost u jedan broj, pokazujući koliko je vaš dan uravnotežen. To je prosjek vaših rezultata spremnosti i aktivnosti.\n\nRezultat 80 predstavlja vašu osobnu osnovicu. To je točka u kojoj se vaši dnevni pokazatelji slažu s vašim 30-dnevnim prosjecima. Pređete li 80, radite iznad uobičajenog. Ako padnete ispod 80, provjerite koja područja vašeg zdravlja trebaju više pažnje.",
    ),
    "scoreMetricsDescriptionReadiness": MessageLookupByLibrary.simpleMessage(
      "Vaš rezultat spremnosti pokazuje koliko se vaše tijelo oporavilo i koliko ste danas spremni za nastup/aktivnost. Temelji se na vašem snu, pulsu u mirovanju i varijabilnosti otkucaja srca.\n\nRezultat 80 je vaša osobna osnovica. To je točka u kojoj se vaše tijelo osjeća uravnoteženo i spremno za normalan dan. Viši rezultati znače da ste napunjeni energijom i spremni za aktivnost. Niži rezultati sugeriraju da vaše tijelo treba više odmora, kvalitetniji san ili lakše kretanje.\n\nSmatrajte ovaj rezultat svojom dnevnom provjerom. Kad je rezultat visok, trebali biste se osjećati energičnije i motiviranije da budete produktivni tog dana.",
    ),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Odaberi jezik"),
    "selectTheme": MessageLookupByLibrary.simpleMessage("Odaberi temu"),
    "settings": MessageLookupByLibrary.simpleMessage("Postavke"),
    "sleep": MessageLookupByLibrary.simpleMessage("Spavanje"),
    "steps": MessageLookupByLibrary.simpleMessage("Koraci"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Tamna"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Svijetla"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage(
      "Automatski (Sistem)",
    ),
    "timeframe1D": MessageLookupByLibrary.simpleMessage("1D"),
    "timeframe1Y": MessageLookupByLibrary.simpleMessage("1G"),
    "timeframe30D": MessageLookupByLibrary.simpleMessage("30D"),
    "timeframe7D": MessageLookupByLibrary.simpleMessage("7D"),
    "timeframeAvg": m16,
    "valueUnitBpm": MessageLookupByLibrary.simpleMessage("bpm"),
    "valueUnitH": MessageLookupByLibrary.simpleMessage("h"),
    "valueUnitKcal": MessageLookupByLibrary.simpleMessage("kcal"),
    "valueUnitMs": MessageLookupByLibrary.simpleMessage("ms"),
    "valueUnitPts": MessageLookupByLibrary.simpleMessage("bod"),
    "valueUnitSteps": MessageLookupByLibrary.simpleMessage("koraka"),
  };
}
