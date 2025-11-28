// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rolla Demo`
  String get appTitle {
    return Intl.message('Rolla Demo', name: 'appTitle', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `What is your name?`
  String get whatIsYourName {
    return Intl.message(
      'What is your name?',
      name: 'whatIsYourName',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get yourName {
    return Intl.message('Your name', name: 'yourName', desc: '', args: []);
  }

  /// `(You can leave this empty and change later)`
  String get youCanLeaveThisEmptyAndChangeLater {
    return Intl.message(
      '(You can leave this empty and change later)',
      name: 'youCanLeaveThisEmptyAndChangeLater',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Home`
  String get homeTitle {
    return Intl.message('Home', name: 'homeTitle', desc: '', args: []);
  }

  /// `Welcome, {name}`
  String welcomeName(Object name) {
    return Intl.message(
      'Welcome, $name',
      name: 'welcomeName',
      desc: '',
      args: [name],
    );
  }

  /// `These are your health scores for today:`
  String get theseAreYourScoresForToday {
    return Intl.message(
      'These are your health scores for today:',
      name: 'theseAreYourScoresForToday',
      desc: '',
      args: [],
    );
  }

  /// `Tap on a score to view its details`
  String get tapOnAScoreToSeeItsDetails {
    return Intl.message(
      'Tap on a score to view its details',
      name: 'tapOnAScoreToSeeItsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Enter Name`
  String get enterName {
    return Intl.message('Enter Name', name: 'enterName', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Select theme`
  String get selectTheme {
    return Intl.message(
      'Select theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Auto (System)`
  String get themeModeSystem {
    return Intl.message(
      'Auto (System)',
      name: 'themeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeModeLight {
    return Intl.message('Light', name: 'themeModeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeModeDark {
    return Intl.message('Dark', name: 'themeModeDark', desc: '', args: []);
  }

  /// `Log Out`
  String get logout {
    return Intl.message('Log Out', name: 'logout', desc: '', args: []);
  }

  /// `You have logged out.`
  String get youHaveLoggedOut {
    return Intl.message(
      'You have logged out.',
      name: 'youHaveLoggedOut',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Health Score`
  String get healthScore {
    return Intl.message(
      'Health Score',
      name: 'healthScore',
      desc: '',
      args: [],
    );
  }

  /// `Readiness`
  String get readiness {
    return Intl.message('Readiness', name: 'readiness', desc: '', args: []);
  }

  /// `Readiness Score`
  String get readinessScore {
    return Intl.message(
      'Readiness Score',
      name: 'readinessScore',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Activity Score`
  String get activityScore {
    return Intl.message(
      'Activity Score',
      name: 'activityScore',
      desc: '',
      args: [],
    );
  }

  /// `Active points`
  String get activePoints {
    return Intl.message(
      'Active points',
      name: 'activePoints',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get steps {
    return Intl.message('Steps', name: 'steps', desc: '', args: []);
  }

  /// `Move hours`
  String get moveHours {
    return Intl.message('Move hours', name: 'moveHours', desc: '', args: []);
  }

  /// `Active calories`
  String get activeCalories {
    return Intl.message(
      'Active calories',
      name: 'activeCalories',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get sleep {
    return Intl.message('Sleep', name: 'sleep', desc: '', args: []);
  }

  /// `Resting HR`
  String get restingHR {
    return Intl.message('Resting HR', name: 'restingHR', desc: '', args: []);
  }

  /// `Overnight HRV`
  String get overnightHRV {
    return Intl.message(
      'Overnight HRV',
      name: 'overnightHRV',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message('No data', name: 'noData', desc: '', args: []);
  }

  /// `Activities`
  String get activities {
    return Intl.message('Activities', name: 'activities', desc: '', args: []);
  }

  /// `Calories`
  String get calories {
    return Intl.message('Calories', name: 'calories', desc: '', args: []);
  }

  /// `{type, select, cardio{Cardio} strength_training{Strength Training} walking{Walking} running{Running} cycling{Cycling} yoga{Yoga} hiit{HIIT} swimming{Swimming} pilates{Pilates} dance{Dance} hiking{Hiking} intervals{Intervals} other{Unknown}}`
  String activityCategory(Object type) {
    return Intl.select(
      type,
      {
        'cardio': 'Cardio',
        'strength_training': 'Strength Training',
        'walking': 'Walking',
        'running': 'Running',
        'cycling': 'Cycling',
        'yoga': 'Yoga',
        'hiit': 'HIIT',
        'swimming': 'Swimming',
        'pilates': 'Pilates',
        'dance': 'Dance',
        'hiking': 'Hiking',
        'intervals': 'Intervals',
        'other': 'Unknown',
      },
      name: 'activityCategory',
      desc: '',
      args: [type],
    );
  }

  /// `No Activities Recorded`
  String get noActivitiesRecorded {
    return Intl.message(
      'No Activities Recorded',
      name: 'noActivitiesRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh`
  String get pullToRefresh {
    return Intl.message(
      'Pull to refresh',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: {date}`
  String lastUpdated(Object date) {
    return Intl.message(
      'Last updated: $date',
      name: 'lastUpdated',
      desc: '',
      args: [date],
    );
  }

  /// `Export PDF`
  String get exportPdf {
    return Intl.message('Export PDF', name: 'exportPdf', desc: '', args: []);
  }

  /// `1D`
  String get timeframe1D {
    return Intl.message('1D', name: 'timeframe1D', desc: '', args: []);
  }

  /// `7D`
  String get timeframe7D {
    return Intl.message('7D', name: 'timeframe7D', desc: '', args: []);
  }

  /// `30D`
  String get timeframe30D {
    return Intl.message('30D', name: 'timeframe30D', desc: '', args: []);
  }

  /// `1Y`
  String get timeframe1Y {
    return Intl.message('1Y', name: 'timeframe1Y', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Insights`
  String get insightsTitle {
    return Intl.message('Insights', name: 'insightsTitle', desc: '', args: []);
  }

  /// `Metrics`
  String get metrics {
    return Intl.message('Metrics', name: 'metrics', desc: '', args: []);
  }

  /// `{timeframe, select, day{} week {Daily Avg.} month {Daily Avg.} year {Daily Avg.} yearMonthly {Monthly Avg.} other{}}`
  String timeframeAvg(Object timeframe) {
    return Intl.select(
      timeframe,
      {
        'day': '',
        'week': 'Daily Avg.',
        'month': 'Daily Avg.',
        'year': 'Daily Avg.',
        'yearMonthly': 'Monthly Avg.',
        'other': '',
      },
      name: 'timeframeAvg',
      desc: '',
      args: [timeframe],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `How It Works?`
  String get howItWorks {
    return Intl.message(
      'How It Works?',
      name: 'howItWorks',
      desc: '',
      args: [],
    );
  }

  /// `Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.`
  String get scoreDescriptionActivity {
    return Intl.message(
      'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.',
      name: 'scoreDescriptionActivity',
      desc: '',
      args: [],
    );
  }

  /// `Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.`
  String get scoreDescriptionReadiness {
    return Intl.message(
      'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.',
      name: 'scoreDescriptionReadiness',
      desc: '',
      args: [],
    );
  }

  /// `Your Health Score brings rest and activity together into one number, showing how balanced your day is. It's the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you're performing beyond your usual. Fall below 80 and see which areas of your health need more attention.`
  String get scoreDescriptionHealth {
    return Intl.message(
      'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.',
      name: 'scoreDescriptionHealth',
      desc: '',
      args: [],
    );
  }

  /// `Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.`
  String get scoreMetricsDescriptionActivity {
    return Intl.message(
      'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.',
      name: 'scoreMetricsDescriptionActivity',
      desc: '',
      args: [],
    );
  }

  /// `Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.`
  String get scoreMetricsDescriptionReadiness {
    return Intl.message(
      'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.',
      name: 'scoreMetricsDescriptionReadiness',
      desc: '',
      args: [],
    );
  }

  /// `Your Health Score brings rest and activity together into one number, showing how balanced your day is. It's the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you're performing beyond your usual. Fall below 80 and see which areas of your health need more attention.`
  String get scoreMetricsDescriptionHealth {
    return Intl.message(
      'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.',
      name: 'scoreMetricsDescriptionHealth',
      desc: '',
      args: [],
    );
  }

  /// `Not enough data to provide insights.`
  String get insightInsufficientData {
    return Intl.message(
      'Not enough data to provide insights.',
      name: 'insightInsufficientData',
      desc: '',
      args: [],
    );
  }

  /// `{metric} is higher than {period}: {value} ({change}% ↑).`
  String insightBetterThanPreviousPeriod(
    Object metric,
    Object period,
    Object value,
    Object change,
  ) {
    return Intl.message(
      '$metric is higher than $period: $value ($change% ↑).',
      name: 'insightBetterThanPreviousPeriod',
      desc: '',
      args: [metric, period, value, change],
    );
  }

  /// `{metric} is lower than {period}: {value} ({change}% ↓).`
  String insightWorseThanPreviousPeriod(
    Object metric,
    Object period,
    Object value,
    Object change,
  ) {
    return Intl.message(
      '$metric is lower than $period: $value ($change% ↓).',
      name: 'insightWorseThanPreviousPeriod',
      desc: '',
      args: [metric, period, value, change],
    );
  }

  /// `{metric} is about the same as {period}: {value}.`
  String insightNoChangeSincePreviousPeriod(
    Object metric,
    Object period,
    Object value,
  ) {
    return Intl.message(
      '$metric is about the same as $period: $value.',
      name: 'insightNoChangeSincePreviousPeriod',
      desc: '',
      args: [metric, period, value],
    );
  }

  /// `{metric} shows a big improvement vs {period}: {value} (+{change}%).`
  String insightBigImprovement(
    Object metric,
    Object period,
    Object value,
    Object change,
  ) {
    return Intl.message(
      '$metric shows a big improvement vs $period: $value (+$change%).',
      name: 'insightBigImprovement',
      desc: '',
      args: [metric, period, value, change],
    );
  }

  /// `{metric} dropped notably vs {period}: {value} ({change}%).`
  String insightBigDrop(
    Object metric,
    Object period,
    Object value,
    Object change,
  ) {
    return Intl.message(
      '$metric dropped notably vs $period: $value ($change%).',
      name: 'insightBigDrop',
      desc: '',
      args: [metric, period, value, change],
    );
  }

  /// `{metric} shows an upward trend over the selected period.`
  String insightUpwardTrend(Object metric) {
    return Intl.message(
      '$metric shows an upward trend over the selected period.',
      name: 'insightUpwardTrend',
      desc: '',
      args: [metric],
    );
  }

  /// `{metric} shows a downward trend over the selected period.`
  String insightDownwardTrend(Object metric) {
    return Intl.message(
      '$metric shows a downward trend over the selected period.',
      name: 'insightDownwardTrend',
      desc: '',
      args: [metric],
    );
  }

  /// `{metric} has been stable over the selected period.`
  String insightStableTrend(Object metric) {
    return Intl.message(
      '$metric has been stable over the selected period.',
      name: 'insightStableTrend',
      desc: '',
      args: [metric],
    );
  }

  /// `{metric} has high variability.`
  String insightHighVariability(Object metric) {
    return Intl.message(
      '$metric has high variability.',
      name: 'insightHighVariability',
      desc: '',
      args: [metric],
    );
  }

  /// `{metric} shows low variability.`
  String insightLowVariability(Object metric) {
    return Intl.message(
      '$metric shows low variability.',
      name: 'insightLowVariability',
      desc: '',
      args: [metric],
    );
  }

  /// `{metric} is meeting the target: {value}.`
  String insightTargetMet(Object metric, Object value) {
    return Intl.message(
      '$metric is meeting the target: $value.',
      name: 'insightTargetMet',
      desc: '',
      args: [metric, value],
    );
  }

  /// `{metric} is below the target: {value}.`
  String insightTargetNotMet(Object metric, Object value) {
    return Intl.message(
      '$metric is below the target: $value.',
      name: 'insightTargetNotMet',
      desc: '',
      args: [metric, value],
    );
  }

  /// `Sleep duration is within the healthy target range: {value}.`
  String insightSleepInTarget(Object value) {
    return Intl.message(
      'Sleep duration is within the healthy target range: $value.',
      name: 'insightSleepInTarget',
      desc: '',
      args: [value],
    );
  }

  /// `Sleep duration is below the healthy range: {value}.`
  String insightSleepTooShort(Object value) {
    return Intl.message(
      'Sleep duration is below the healthy range: $value.',
      name: 'insightSleepTooShort',
      desc: '',
      args: [value],
    );
  }

  /// `Sleep duration is above the healthy range: {value}.`
  String insightSleepTooLong(Object value) {
    return Intl.message(
      'Sleep duration is above the healthy range: $value.',
      name: 'insightSleepTooLong',
      desc: '',
      args: [value],
    );
  }

  /// `yesterday`
  String get periodYesterday {
    return Intl.message(
      'yesterday',
      name: 'periodYesterday',
      desc: '',
      args: [],
    );
  }

  /// `last week`
  String get periodLastWeek {
    return Intl.message(
      'last week',
      name: 'periodLastWeek',
      desc: '',
      args: [],
    );
  }

  /// `last month`
  String get periodLastMonth {
    return Intl.message(
      'last month',
      name: 'periodLastMonth',
      desc: '',
      args: [],
    );
  }

  /// `last year`
  String get periodLastYear {
    return Intl.message(
      'last year',
      name: 'periodLastYear',
      desc: '',
      args: [],
    );
  }

  /// `—`
  String get plusInfinity {
    return Intl.message('—', name: 'plusInfinity', desc: '', args: []);
  }

  /// `pts`
  String get valueUnitPts {
    return Intl.message('pts', name: 'valueUnitPts', desc: '', args: []);
  }

  /// `h`
  String get valueUnitH {
    return Intl.message('h', name: 'valueUnitH', desc: '', args: []);
  }

  /// `bpm`
  String get valueUnitBpm {
    return Intl.message('bpm', name: 'valueUnitBpm', desc: '', args: []);
  }

  /// `ms`
  String get valueUnitMs {
    return Intl.message('ms', name: 'valueUnitMs', desc: '', args: []);
  }

  /// `steps`
  String get valueUnitSteps {
    return Intl.message('steps', name: 'valueUnitSteps', desc: '', args: []);
  }

  /// `kcal`
  String get valueUnitKcal {
    return Intl.message('kcal', name: 'valueUnitKcal', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
