import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/extensions/list/list_of_num_average.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score_activity.dart';

class Score extends Equatable {
  final int id;
  final DateTime date;
  final double sleepMinutes;
  final double restingHeartRateBpm;
  final double overnightHeartRateVarianceMs;
  final double activePoints;
  final double steps;
  final double moveHours;
  final double activeCalories;
  final List<ScoreActivity> activities;

  const Score({
    required this.id,
    required this.date,
    required this.sleepMinutes,
    required this.restingHeartRateBpm,
    required this.overnightHeartRateVarianceMs,
    required this.activePoints,
    required this.steps,
    required this.moveHours,
    required this.activeCalories,
    required this.activities,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    sleepMinutes,
    restingHeartRateBpm,
    overnightHeartRateVarianceMs,
    activePoints,
    steps,
    moveHours,
    activeCalories,
    activities,
  ];

  int get readinessScore => [
    sleepScore,
    restingHeartRateScore,
    overnightHeartRateVarianceScore,
  ].average.round();

  int get activityScore =>
      [activePointsScore, stepsScore, moveHoursScore].average.round();

  int get healthScore => [readinessScore, activityScore].average.round();

  int get sleepScore =>
      _scoreFor(sleepMinutes, sleepMinutesTarget, sleepMinutesRange);

  // Resting heart rate (bpm)
  // Uses restingHeartRateBpmTarget and restingHeartRateBpmRange
  int get restingHeartRateScore => _scoreFor(
    restingHeartRateBpm,
    restingHeartRateBpmTarget,
    restingHeartRateBpmRange,
  );

  // Overnight heart-rate variance (ms)
  // Uses overnightHeartRateVarianceMsTarget and overnightHeartRateVarianceMsRange
  int get overnightHeartRateVarianceScore => _scoreFor(
    overnightHeartRateVarianceMs,
    overnightHeartRateVarianceMsTarget,
    overnightHeartRateVarianceMsRange,
  );

  // Active points (app-specific)
  // Uses activePointsTarget and activePointsRange
  int get activePointsScore =>
      _scoreFor(activePoints, activePointsTarget, null);

  // Steps (int)
  // Uses stepsTarget and stepsRange
  int get stepsScore => _scoreFor(steps, stepsTarget.toDouble(), null);

  // Move hours (hours)
  // Uses moveHoursTarget and moveHoursRange
  int get moveHoursScore => _scoreFor(moveHours, moveHoursTarget, null);

  /// Returns a 0..100 score for [value] when a range is provided.
  /// If [range] is null, assumes min=0 and max=target and returns (value/target)*100.
  int _scoreFor(num? value, double target, RangeValues? range) {
    if (value == null) return 0;
    final double v = value.toDouble();

    // No explicit range: assume [0, target] and linear mapping
    if (range == null) {
      if (target <= 0) return 0;
      final double raw = (v / target) * 100.0;
      return raw.clamp(0.0, 100.0).round();
    }

    final double min = range.start;
    final double max = range.end;

    // Protect degenerate ranges
    if (max <= min) {
      // fallback to linear to target
      if (target <= 0) return 0;
      final double raw = (v / target) * 100.0;
      return raw.clamp(0.0, 100.0).round();
    }

    // Clamp value into the provided healthy range so edges map to 0 and target maps to 100.
    final double clamped = v.clamp(min, max);

    // If exactly at the target -> perfect score
    if ((clamped - target).abs() < 1e-9) return 100;

    if (clamped > target) {
      final double denom = max - target;
      if (denom <= 0) return clamped == target ? 100 : 0;
      final double frac = 1.0 - ((clamped - target) / denom);
      return (frac * 100.0).clamp(0.0, 100.0).round();
    } else {
      // clamped < target
      final double denom = target - min;
      if (denom <= 0) return clamped == target ? 100 : 0;
      final double frac = 1.0 - ((target - clamped) / denom);
      return (frac * 100.0).clamp(0.0, 100.0).round();
    }
  }

  // Sleep (minutes)
  // Target: 8 hours (480 min). Healthy adult range: 7–9 hours.
  static const double sleepMinutesTarget = 480.0;
  static const RangeValues sleepMinutesRange = RangeValues(420.0, 540.0);

  // Resting heart rate (bpm)
  // Target: ~60 bpm (fits many adults). range for non-athletes: 50–100 bpm.
  static const double restingHeartRateBpmTarget = 60.0;
  static const RangeValues restingHeartRateBpmRange = RangeValues(50.0, 100.0);

  // Overnight heart-rate variability (ms)
  // Target: ~50 ms (higher is generally better; large individual variation).
  // Broad expected range for RMSSD-like measures: 20–100 ms.
  static const double overnightHeartRateVarianceMsTarget = 50.0;
  static const RangeValues overnightHeartRateVarianceMsRange = RangeValues(
    20.0,
    100.0,
  );

  // Active points (app-specific / gamified metric)
  // Target: 300 points/day.
  static const double activePointsTarget = 300.0;

  // Steps
  // Target: 7,500 steps/day (good middle ground between older "10k" and lower recommendations).
  // Typical useful range: 5,000–12,000 steps.
  static const int stepsTarget = 7500;

  // Move hours (hours spent moving / non-sedentary)
  // Target: 6.0 hours/day of meaningful movement.
  // Reasonable range: 1–4 hours depending on lifestyle.
  static const double moveHoursTarget = 6.0;
}
