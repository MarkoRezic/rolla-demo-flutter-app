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

  static String m0(date) => "Zadnje ažuriranje: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activity": MessageLookupByLibrary.simpleMessage("Aktivnost"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Rolla Demo"),
    "exportPdf": MessageLookupByLibrary.simpleMessage("Izvezi u PDF"),
    "health": MessageLookupByLibrary.simpleMessage("Zdravlje"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Rezultati"),
    "insightsTitle": MessageLookupByLibrary.simpleMessage("Uvidi"),
    "language": MessageLookupByLibrary.simpleMessage("Jezik"),
    "lastUpdated": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Odjava"),
    "metricAvg": MessageLookupByLibrary.simpleMessage("Prosjek"),
    "noData": MessageLookupByLibrary.simpleMessage("Nema podataka"),
    "pullToRefresh": MessageLookupByLibrary.simpleMessage(
      "Povuci za osvježenje",
    ),
    "readiness": MessageLookupByLibrary.simpleMessage("Spremnost"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Odaberi jezik"),
    "selectTheme": MessageLookupByLibrary.simpleMessage("Odaberi temu"),
    "settings": MessageLookupByLibrary.simpleMessage("Postavke"),
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
  };
}
