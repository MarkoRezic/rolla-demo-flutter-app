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

  Score.zero()
    : id = 0,
      date = DateTime.now(),
      sleepMinutes = 0,
      restingHeartRateBpm = 0,
      overnightHeartRateVarianceMs = 0,
      activePoints = 0,
      steps = 0,
      moveHours = 0,
      activeCalories = 0,
      activities = const [];

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

  int get sleepScore => _scoreFor(
    sleepMinutes,
    targetRange: sleepMinutesTargetRange,
    range: sleepMinutesRange,
  );

  // Resting heart rate (bpm)
  // Uses restingHeartRateBpmTarget and restingHeartRateBpmRange
  int get restingHeartRateScore => _scoreFor(
    restingHeartRateBpm,
    targetRange: restingHeartRateBpmTargetRange,
    range: restingHeartRateBpmRange,
  );

  // Overnight heart-rate variance (ms)
  // Uses overnightHeartRateVarianceMsTarget and overnightHeartRateVarianceMsRange
  int get overnightHeartRateVarianceScore => _scoreFor(
    overnightHeartRateVarianceMs,
    target: overnightHeartRateVarianceMsTarget,
    range: overnightHeartRateVarianceMsRange,
  );

  // Active points (app-specific)
  // Uses activePointsTarget and activePointsRange
  int get activePointsScore =>
      _scoreFor(activePoints, target: activePointsTarget);

  // Steps (int)
  // Uses stepsTarget and stepsRange
  int get stepsScore => _scoreFor(steps, target: stepsTarget.toDouble());

  // Move hours (hours)
  // Uses moveHoursTarget and moveHoursRange
  int get moveHoursScore => _scoreFor(moveHours, target: moveHoursTarget);

  /// Returns a 0..100 score for [value].
  /// Provide either [target] or [targetRange], not both.
  /// If [targetRange] is provided:
  ///   - value inside the target range => 100
  ///   - value outside => score falls off linearly with distance to the nearest edge;
  ///     at a distance equal to the range width the score is 0.
  /// If [targetRange] is not provided, the previous behavior using [target] and
  /// optional [range] is used.
  int _scoreFor(
    num? value, {
    double? target,
    RangeValues? range,
    RangeValues? targetRange,
  }) {
    // Only one of target or targetRange must be provided.
    assert(
      !(target != null && targetRange != null),
      'Provide either target or targetRange, not both.',
    );

    if (value == null) return 0;
    final double v = value.toDouble();

    // If targetRange is provided -> new behavior
    if (targetRange != null) {
      final double start = targetRange.start;
      final double end = targetRange.end;

      // Degenerate targetRange (a single point or reversed)
      if (end <= start) {
        // Exact match gives perfect score, otherwise 0
        return ((v - start).abs() < 1e-9) ? 100 : 0;
      }

      // Inside targetRange -> perfect score
      if (v >= start && v <= end) return 100;

      final double width = end - start;
      // distance to nearest edge
      final double dist = v < start ? (start - v) : (v - end);

      // Linear falloff over one range width: frac = 1 - dist/width
      final double frac = 1.0 - (dist / width);
      final double raw = (frac * 100.0).clamp(0.0, 100.0);
      return raw.round();
    }

    // --- Fall back to original logic which requires `target` ---
    if (target == null) return 0;

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
  // Healthy adult target range: 7–9 hours.
  static const RangeValues sleepMinutesTargetRange = RangeValues(
    7 * 60,
    9 * 60,
  );
  static const RangeValues sleepMinutesRange = RangeValues(0 * 60, 14 * 60);

  // Resting heart rate (bpm)
  // Target range for non-athletes: 60–100 bpm.
  static const RangeValues restingHeartRateBpmTargetRange = RangeValues(
    60,
    100,
  );
  static const RangeValues restingHeartRateBpmRange = RangeValues(35, 150.0);

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

  Score operator +(Score other) {
    return Score(
      id: 0,
      date: date,
      sleepMinutes: sleepMinutes + other.sleepMinutes,
      restingHeartRateBpm: restingHeartRateBpm + other.restingHeartRateBpm,
      overnightHeartRateVarianceMs:
          overnightHeartRateVarianceMs + other.overnightHeartRateVarianceMs,
      activePoints: activePoints + other.activePoints,
      steps: steps + other.steps,
      moveHours: moveHours + other.moveHours,
      activeCalories: activeCalories + other.activeCalories,
      activities: [...activities, ...other.activities],
    );
  }

  Score operator /(double divisor) {
    return Score(
      id: id,
      date: date,
      sleepMinutes: sleepMinutes / divisor,
      restingHeartRateBpm: restingHeartRateBpm / divisor,
      overnightHeartRateVarianceMs: overnightHeartRateVarianceMs / divisor,
      activePoints: activePoints / divisor,
      steps: steps / divisor,
      moveHours: moveHours / divisor,
      activeCalories: activeCalories / divisor,
      activities: activities,
    );
  }
}
