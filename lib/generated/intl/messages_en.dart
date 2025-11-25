// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(date) => "Last updated: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Rolla Demo"),
    "exportPdf": MessageLookupByLibrary.simpleMessage("Export PDF"),
    "health": MessageLookupByLibrary.simpleMessage("Health"),
    "healthScore": MessageLookupByLibrary.simpleMessage("Health Score"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Scores"),
    "howItWorks": MessageLookupByLibrary.simpleMessage("How It Works?"),
    "insightsTitle": MessageLookupByLibrary.simpleMessage("Insights"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastUpdated": m0,
    "logout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "metricAvg": MessageLookupByLibrary.simpleMessage("Avg"),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "pullToRefresh": MessageLookupByLibrary.simpleMessage("Pull to refresh"),
    "readiness": MessageLookupByLibrary.simpleMessage("Readiness"),
    "scoreDescriptionActivity": MessageLookupByLibrary.simpleMessage(
      "Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.",
    ),
    "scoreDescriptionHealth": MessageLookupByLibrary.simpleMessage(
      "Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.",
    ),
    "scoreDescriptionReadiness": MessageLookupByLibrary.simpleMessage(
      "Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.",
    ),
    "scoreMetricsDescriptionActivity": MessageLookupByLibrary.simpleMessage(
      "Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.",
    ),
    "scoreMetricsDescriptionHealth": MessageLookupByLibrary.simpleMessage(
      "Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.",
    ),
    "scoreMetricsDescriptionReadiness": MessageLookupByLibrary.simpleMessage(
      "Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.",
    ),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select language"),
    "selectTheme": MessageLookupByLibrary.simpleMessage("Select theme"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("Auto (System)"),
    "timeframe1D": MessageLookupByLibrary.simpleMessage("1D"),
    "timeframe1Y": MessageLookupByLibrary.simpleMessage("1Y"),
    "timeframe30D": MessageLookupByLibrary.simpleMessage("30D"),
    "timeframe7D": MessageLookupByLibrary.simpleMessage("7D"),
  };
}
