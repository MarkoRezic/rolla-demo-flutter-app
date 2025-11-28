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
  String get welcome => 'Welcome';

  @override
  String get whatIsYourName => 'What is your name?';

  @override
  String get yourName => 'Your name';

  @override
  String get youCanLeaveThisEmptyAndChangeLater =>
      '(You can leave this empty and change later)';

  @override
  String get continueText => 'Continue';

  @override
  String get homeTitle => 'Home';

  @override
  String welcomeName(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get theseAreYourScoresForToday =>
      'These are your health scores for today:';

  @override
  String get tapOnAScoreToSeeItsDetails => 'Tap on a score to view its details';

  @override
  String get error => 'Error';

  @override
  String get settings => 'Settings';

  @override
  String get userName => 'User Name';

  @override
  String get enterName => 'Enter Name';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get theme => 'Theme';

  @override
  String get selectTheme => 'Select theme';

  @override
  String get themeModeSystem => 'Auto (System)';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get logout => 'Log Out';

  @override
  String get youHaveLoggedOut => 'You have logged out.';

  @override
  String get history => 'History';

  @override
  String get health => 'Health';

  @override
  String get healthScore => 'Health Score';

  @override
  String get readiness => 'Readiness';

  @override
  String get readinessScore => 'Readiness Score';

  @override
  String get activity => 'Activity';

  @override
  String get activityScore => 'Activity Score';

  @override
  String get activePoints => 'Active points';

  @override
  String get steps => 'Steps';

  @override
  String get moveHours => 'Move hours';

  @override
  String get activeCalories => 'Active calories';

  @override
  String get sleep => 'Sleep';

  @override
  String get restingHR => 'Resting HR';

  @override
  String get overnightHRV => 'Overnight HRV';

  @override
  String get noData => 'No data';

  @override
  String get activities => 'Activities';

  @override
  String get calories => 'Calories';

  @override
  String activityCategory(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
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
    });
    return '$_temp0';
  }

  @override
  String get noActivitiesRecorded => 'No Activities Recorded';

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
  String get monthly => 'Monthly';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get metrics => 'Metrics';

  @override
  String timeframeAvg(String timeframe) {
    String _temp0 = intl.Intl.selectLogic(timeframe, {
      'day': '',
      'week': 'Daily Avg.',
      'month': 'Daily Avg.',
      'year': 'Daily Avg.',
      'yearMonthly': 'Monthly Avg.',
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
      'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.';

  @override
  String get scoreDescriptionReadiness =>
      'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.';

  @override
  String get scoreDescriptionHealth =>
      'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.';

  @override
  String get scoreMetricsDescriptionActivity =>
      'Your Activity Score measures how much you’ve moved throughout the day and how consistent your activity has been. It looks at your steps, active points, and move hours to capture both effort and frequency.\n\nA score of 80 represents your personal baseline, your typical daily activity over the past 30 days. Higher scores mean you’ve gone above your usual pace or intensity. Lower scores show lighter movement or more rest than normal.\n\nUse this score as your motivation to stay active in a balanced way.';

  @override
  String get scoreMetricsDescriptionReadiness =>
      'Your Readiness Score shows how well your body has recovered and how prepared you are to perform today. It’s based on your sleep, resting heart rate, and heart rate variability.\n\nA score of 80 is your personal baseline. The point where your body feels balanced and ready for a normal day. Higher scores mean you’re recharged and primed for activity. Lower scores suggest your body needs more rest, better sleep, or lighter movement.\n\nThink of this score as your daily check-in. When your score is high, you should feel more energetic and motivated to be productive that day.';

  @override
  String get scoreMetricsDescriptionHealth =>
      'Your Health Score brings rest and activity together into one number, showing how balanced your day is. It\'s the average of your Readiness and Activity scores.\n\nA score of 80 represents your personal baseline. This is the point where your daily metrics align with your 30-day averages. Get above 80 and you\'re performing beyond your usual. Fall below 80 and see which areas of your health need more attention.';

  @override
  String get insightInsufficientData => 'Not enough data to provide insights.';

  @override
  String insightBetterThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric is higher than $period: $value ($change% ↑).';
  }

  @override
  String insightWorseThanPreviousPeriod(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric is lower than $period: $value ($change% ↓).';
  }

  @override
  String insightNoChangeSincePreviousPeriod(
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric is about the same as $period: $value.';
  }

  @override
  String insightBigImprovement(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric shows a big improvement vs $period: $value (+$change%).';
  }

  @override
  String insightBigDrop(
    Object change,
    Object metric,
    Object period,
    Object value,
  ) {
    return '$metric dropped notably vs $period: $value ($change%).';
  }

  @override
  String insightUpwardTrend(Object metric) {
    return '$metric shows an upward trend over the selected period.';
  }

  @override
  String insightDownwardTrend(Object metric) {
    return '$metric shows a downward trend over the selected period.';
  }

  @override
  String insightStableTrend(Object metric) {
    return '$metric has been stable over the selected period.';
  }

  @override
  String insightHighVariability(Object metric) {
    return '$metric has high variability.';
  }

  @override
  String insightLowVariability(Object metric) {
    return '$metric shows low variability.';
  }

  @override
  String insightTargetMet(Object metric, Object value) {
    return '$metric is meeting the target: $value.';
  }

  @override
  String insightTargetNotMet(Object metric, Object value) {
    return '$metric is below the target: $value.';
  }

  @override
  String insightSleepInTarget(Object value) {
    return 'Sleep duration is within the healthy target range: $value.';
  }

  @override
  String insightSleepTooShort(Object value) {
    return 'Sleep duration is below the healthy range: $value.';
  }

  @override
  String insightSleepTooLong(Object value) {
    return 'Sleep duration is above the healthy range: $value.';
  }

  @override
  String get periodYesterday => 'yesterday';

  @override
  String get periodLastWeek => 'last week';

  @override
  String get periodLastMonth => 'last month';

  @override
  String get periodLastYear => 'last year';

  @override
  String get plusInfinity => '—';

  @override
  String get valueUnitPts => 'pts';

  @override
  String get valueUnitH => 'h';

  @override
  String get valueUnitBpm => 'bpm';

  @override
  String get valueUnitMs => 'ms';

  @override
  String get valueUnitSteps => 'steps';

  @override
  String get valueUnitKcal => 'kcal';
}
