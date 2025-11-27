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

  static String m0(metric, period, value, change) =>
      "${metric} is higher than ${period}: ${value} (${change}% ↑).";

  static String m1(metric, period, value, change) =>
      "${metric} dropped notably vs ${period}: ${value} (${change}%).";

  static String m2(metric, period, value, change) =>
      "${metric} shows a big improvement vs ${period}: ${value} (+${change}%).";

  static String m3(metric) =>
      "${metric} shows a downward trend over the selected period.";

  static String m4(metric, sd) => "${metric} has high variability (SD ${sd}).";

  static String m5(metric) => "${metric} shows low variability.";

  static String m6(metric, period, value) =>
      "${metric} is about the same as ${period}: ${value}.";

  static String m7(value) =>
      "Sleep duration is within the healthy target range: ${value}.";

  static String m8(value) =>
      "Sleep duration is above the healthy range: ${value}.";

  static String m9(value) =>
      "Sleep duration is below the healthy range: ${value}.";

  static String m10(metric) =>
      "${metric} has been stable over the selected period.";

  static String m11(metric, value) =>
      "${metric} is meeting the target: ${value}.";

  static String m12(metric, value) =>
      "${metric} is below the target: ${value}.";

  static String m13(metric) =>
      "${metric} shows an upward trend over the selected period.";

  static String m14(metric, period, value, change) =>
      "${metric} is lower than ${period}: ${value} (${change}% ↓).";

  static String m15(date) => "Last updated: ${date}";

  static String m16(timeframe) =>
      "${Intl.select(timeframe, {'day': '', 'week': 'Daily Avg.', 'month': 'Daily Avg.', 'year': 'Daily Avg.', 'yearMonthly': 'Monthly Avg.', 'other': ''})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "activeCalories": MessageLookupByLibrary.simpleMessage("Active calories"),
    "activePoints": MessageLookupByLibrary.simpleMessage("Active points"),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "activityScore": MessageLookupByLibrary.simpleMessage("Activity Score"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Rolla Demo"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "exportPdf": MessageLookupByLibrary.simpleMessage("Export PDF"),
    "health": MessageLookupByLibrary.simpleMessage("Health"),
    "healthScore": MessageLookupByLibrary.simpleMessage("Health Score"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Scores"),
    "howItWorks": MessageLookupByLibrary.simpleMessage("How It Works?"),
    "insightBetterThanPreviousPeriod": m0,
    "insightBigDrop": m1,
    "insightBigImprovement": m2,
    "insightDownwardTrend": m3,
    "insightHighVariability": m4,
    "insightInsufficientData": MessageLookupByLibrary.simpleMessage(
      "Not enough data to provide insights.",
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
    "insightsTitle": MessageLookupByLibrary.simpleMessage("Insights"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastUpdated": m15,
    "logout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "metrics": MessageLookupByLibrary.simpleMessage("Metrics"),
    "monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "moveHours": MessageLookupByLibrary.simpleMessage("Move hours"),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "overnightHRV": MessageLookupByLibrary.simpleMessage("Overnight HRV"),
    "periodLastMonth": MessageLookupByLibrary.simpleMessage("last month"),
    "periodLastWeek": MessageLookupByLibrary.simpleMessage("last week"),
    "periodLastYear": MessageLookupByLibrary.simpleMessage("last year"),
    "periodYesterday": MessageLookupByLibrary.simpleMessage("yesterday"),
    "plusInfinity": MessageLookupByLibrary.simpleMessage("—"),
    "pullToRefresh": MessageLookupByLibrary.simpleMessage("Pull to refresh"),
    "readiness": MessageLookupByLibrary.simpleMessage("Readiness"),
    "readinessScore": MessageLookupByLibrary.simpleMessage("Readiness Score"),
    "restingHR": MessageLookupByLibrary.simpleMessage("Resting HR"),
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
    "sleep": MessageLookupByLibrary.simpleMessage("Sleep"),
    "steps": MessageLookupByLibrary.simpleMessage("Steps"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("Auto (System)"),
    "timeframe1D": MessageLookupByLibrary.simpleMessage("1D"),
    "timeframe1Y": MessageLookupByLibrary.simpleMessage("1Y"),
    "timeframe30D": MessageLookupByLibrary.simpleMessage("30D"),
    "timeframe7D": MessageLookupByLibrary.simpleMessage("7D"),
    "timeframeAvg": m16,
    "valueUnitBpm": MessageLookupByLibrary.simpleMessage("bpm"),
    "valueUnitH": MessageLookupByLibrary.simpleMessage("h"),
    "valueUnitKcal": MessageLookupByLibrary.simpleMessage("kcal"),
    "valueUnitMs": MessageLookupByLibrary.simpleMessage("ms"),
    "valueUnitPts": MessageLookupByLibrary.simpleMessage("pts"),
    "valueUnitSteps": MessageLookupByLibrary.simpleMessage("steps"),
  };
}
