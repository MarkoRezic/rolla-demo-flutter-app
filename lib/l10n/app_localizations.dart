import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Rolla Demo'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @whatIsYourName.
  ///
  /// In en, this message translates to:
  /// **'What is your name?'**
  String get whatIsYourName;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @youCanLeaveThisEmptyAndChangeLater.
  ///
  /// In en, this message translates to:
  /// **'(You can leave this empty and change later)'**
  String get youCanLeaveThisEmptyAndChangeLater;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @welcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcomeName(Object name);

  /// No description provided for @theseAreYourScoresForToday.
  ///
  /// In en, this message translates to:
  /// **'These are your health scores for today:'**
  String get theseAreYourScoresForToday;

  /// No description provided for @tapOnAScoreToSeeItsDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap on a score to view its details'**
  String get tapOnAScoreToSeeItsDetails;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select theme'**
  String get selectTheme;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'Auto (System)'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @youHaveLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'You have logged out.'**
  String get youHaveLoggedOut;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @healthScore.
  ///
  /// In en, this message translates to:
  /// **'Health Score'**
  String get healthScore;

  /// No description provided for @readiness.
  ///
  /// In en, this message translates to:
  /// **'Readiness'**
  String get readiness;

  /// No description provided for @readinessScore.
  ///
  /// In en, this message translates to:
  /// **'Readiness Score'**
  String get readinessScore;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @activityScore.
  ///
  /// In en, this message translates to:
  /// **'Activity Score'**
  String get activityScore;

  /// No description provided for @activePoints.
  ///
  /// In en, this message translates to:
  /// **'Active points'**
  String get activePoints;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @moveHours.
  ///
  /// In en, this message translates to:
  /// **'Move hours'**
  String get moveHours;

  /// No description provided for @activeCalories.
  ///
  /// In en, this message translates to:
  /// **'Active calories'**
  String get activeCalories;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @restingHR.
  ///
  /// In en, this message translates to:
  /// **'Resting HR'**
  String get restingHR;

  /// No description provided for @overnightHRV.
  ///
  /// In en, this message translates to:
  /// **'Overnight HRV'**
  String get overnightHRV;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @activityCategory.
  ///
  /// In en, this message translates to:
  /// **'{type, select, cardio{Cardio} strength_training{Strength Training} walking{Walking} running{Running} cycling{Cycling} yoga{Yoga} hiit{HIIT} swimming{Swimming} pilates{Pilates} dance{Dance} hiking{Hiking} intervals{Intervals} other{Unknown}}'**
  String activityCategory(String type);

  /// No description provided for @noActivitiesRecorded.
  ///
  /// In en, this message translates to:
  /// **'No Activities Recorded'**
  String get noActivitiesRecorded;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String lastUpdated(Object date);

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @timeframe1D.
  ///
  /// In en, this message translates to:
  /// **'1D'**
  String get timeframe1D;

  /// No description provided for @timeframe7D.
  ///
  /// In en, this message translates to:
  /// **'7D'**
  String get timeframe7D;

  /// No description provided for @timeframe30D.
  ///
  /// In en, this message translates to:
  /// **'30D'**
  String get timeframe30D;

  /// No description provided for @timeframe1Y.
  ///
  /// In en, this message translates to:
  /// **'1Y'**
  String get timeframe1Y;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @metrics.
  ///
  /// In en, this message translates to:
  /// **'Metrics'**
  String get metrics;

  /// No description provided for @timeframeAvg.
  ///
  /// In en, this message translates to:
  /// **'{timeframe, select, day{} week {Daily Avg.} month {Daily Avg.} year {Daily Avg.} yearMonthly {Monthly Avg.} other{}}'**
  String timeframeAvg(String timeframe);

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @howItWorks.
  ///
  /// In en, this message translates to:
  /// **'How It Works?'**
  String get howItWorks;

  /// No description provided for @scoreDescriptionActivity.
  ///
  /// In en, this message translates to:
  /// **'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.'**
  String get scoreDescriptionActivity;

  /// No description provided for @scoreDescriptionReadiness.
  ///
  /// In en, this message translates to:
  /// **'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.'**
  String get scoreDescriptionReadiness;

  /// No description provided for @scoreDescriptionHealth.
  ///
  /// In en, this message translates to:
  /// **'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.'**
  String get scoreDescriptionHealth;

  /// No description provided for @scoreMetricsDescriptionActivity.
  ///
  /// In en, this message translates to:
  /// **'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.'**
  String get scoreMetricsDescriptionActivity;

  /// No description provided for @scoreMetricsDescriptionReadiness.
  ///
  /// In en, this message translates to:
  /// **'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.'**
  String get scoreMetricsDescriptionReadiness;

  /// No description provided for @scoreMetricsDescriptionHealth.
  ///
  /// In en, this message translates to:
  /// **'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.'**
  String get scoreMetricsDescriptionHealth;

  /// No description provided for @insightInsufficientData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data to provide insights.'**
  String get insightInsufficientData;

  /// No description provided for @insightBetterThanPreviousPeriod.
  ///
  /// In en, this message translates to:
  /// **'{metric} is higher than {period}: {value} ({change}% ↑).'**
  String insightBetterThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  );

  /// No description provided for @insightWorseThanPreviousPeriod.
  ///
  /// In en, this message translates to:
  /// **'{metric} is lower than {period}: {value} ({change}% ↓).'**
  String insightWorseThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  );

  /// No description provided for @insightNoChangeSincePreviousPeriod.
  ///
  /// In en, this message translates to:
  /// **'{metric} is about the same as {period}: {value}.'**
  String insightNoChangeSincePreviousPeriod(
    Object metric,
    Object period,
    Object value,
  );

  /// No description provided for @insightBigImprovement.
  ///
  /// In en, this message translates to:
  /// **'{metric} shows a big improvement vs {period}: {value} (+{change}%).'**
  String insightBigImprovement(
    Object change,
    Object metric,
    Object period,
    Object value,
  );

  /// No description provided for @insightBigDrop.
  ///
  /// In en, this message translates to:
  /// **'{metric} dropped notably vs {period}: {value} ({change}%).'**
  String insightBigDrop(
    Object change,
    Object metric,
    Object period,
    Object value,
  );

  /// No description provided for @insightUpwardTrend.
  ///
  /// In en, this message translates to:
  /// **'{metric} shows an upward trend over the selected period.'**
  String insightUpwardTrend(Object metric);

  /// No description provided for @insightDownwardTrend.
  ///
  /// In en, this message translates to:
  /// **'{metric} shows a downward trend over the selected period.'**
  String insightDownwardTrend(Object metric);

  /// No description provided for @insightStableTrend.
  ///
  /// In en, this message translates to:
  /// **'{metric} has been stable over the selected period.'**
  String insightStableTrend(Object metric);

  /// No description provided for @insightHighVariability.
  ///
  /// In en, this message translates to:
  /// **'{metric} has high variability.'**
  String insightHighVariability(Object metric);

  /// No description provided for @insightLowVariability.
  ///
  /// In en, this message translates to:
  /// **'{metric} shows low variability.'**
  String insightLowVariability(Object metric);

  /// No description provided for @insightTargetMet.
  ///
  /// In en, this message translates to:
  /// **'{metric} is meeting the target: {value}.'**
  String insightTargetMet(Object metric, Object value);

  /// No description provided for @insightTargetNotMet.
  ///
  /// In en, this message translates to:
  /// **'{metric} is below the target: {value}.'**
  String insightTargetNotMet(Object metric, Object value);

  /// No description provided for @insightSleepInTarget.
  ///
  /// In en, this message translates to:
  /// **'Sleep duration is within the healthy target range: {value}.'**
  String insightSleepInTarget(Object value);

  /// No description provided for @insightSleepTooShort.
  ///
  /// In en, this message translates to:
  /// **'Sleep duration is below the healthy range: {value}.'**
  String insightSleepTooShort(Object value);

  /// No description provided for @insightSleepTooLong.
  ///
  /// In en, this message translates to:
  /// **'Sleep duration is above the healthy range: {value}.'**
  String insightSleepTooLong(Object value);

  /// No description provided for @periodYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get periodYesterday;

  /// No description provided for @periodLastWeek.
  ///
  /// In en, this message translates to:
  /// **'last week'**
  String get periodLastWeek;

  /// No description provided for @periodLastMonth.
  ///
  /// In en, this message translates to:
  /// **'last month'**
  String get periodLastMonth;

  /// No description provided for @periodLastYear.
  ///
  /// In en, this message translates to:
  /// **'last year'**
  String get periodLastYear;

  /// No description provided for @plusInfinity.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get plusInfinity;

  /// No description provided for @valueUnitPts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get valueUnitPts;

  /// No description provided for @valueUnitH.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get valueUnitH;

  /// No description provided for @valueUnitBpm.
  ///
  /// In en, this message translates to:
  /// **'bpm'**
  String get valueUnitBpm;

  /// No description provided for @valueUnitMs.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get valueUnitMs;

  /// No description provided for @valueUnitSteps.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get valueUnitSteps;

  /// No description provided for @valueUnitKcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get valueUnitKcal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hr':
      return AppLocalizationsHr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
