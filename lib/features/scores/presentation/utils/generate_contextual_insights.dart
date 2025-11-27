import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/timeframe.dart';

// Define metric descriptors per ScoreType.
// Each metric descriptor provides:
//  - label: translation getter (already present in project such as tr.activePoints)
//  - getter: function to extract numeric value from Score
//  - unitKey: translation getter for unit text
//  - optional targets / ranges for target checks (sleep / hrv / hr / steps / activePoints / moveHours)
class _Metric {
  final String label;
  final double Function(Score) getter;
  final String unit;
  final double? target; // null if not used
  final RangeValues? targetRange; // optional

  _Metric(this.label, this.getter, this.unit, {this.target, this.targetRange});
}

/// Returns a list of contextual insights for the currently visible metrics.
///
/// - `timeframe`: the selected timeframe (day/week/month/year)
/// - `scores`: the list of available Score objects (can be many periods)
/// - `scoreType`: activity/readiness/health (filters which metrics to produce)
/// - `currentDateScore`: the selected date score (for day view this is typically the day's score),
///    can be null — function will attempt to infer a current period from `scores`.
List<String> generateContextualInsights(
  Timeframe timeframe,
  List<Score> scores,
  ScoreType scoreType,
  Score? currentDateScore,
) {
  // Safety / quick-return
  if (scores.isEmpty && currentDateScore == null) {
    return [tr.insightInsufficientData];
  }

  // Helpers: numeric stats
  double mean(List<double> xs) {
    if (xs.isEmpty) return 0.0;
    return xs.reduce((a, b) => a + b) / xs.length;
  }

  double stdDev(List<double> xs) {
    if (xs.length < 2) return 0.0;
    final m = mean(xs);
    final varSum =
        xs.map((x) => pow(x - m, 2)).reduce((a, b) => a + b) / (xs.length - 1);
    return sqrt(varSum.toDouble());
  }

  double percentChange(double oldVal, double newVal) {
    if (oldVal == 0) return newVal == 0 ? 0.0 : double.infinity;
    return (newVal - oldVal) / oldVal;
  }

  DateTime startOfWeek(DateTime d) {
    // Monday-start week
    return DateTime(
      d.year,
      d.month,
      d.day,
    ).subtract(Duration(days: d.weekday - 1));
  }

  /// compute inclusive [start, end] for a given date and timeframe
  DateTimeRange periodRangeForDate(DateTime date, Timeframe tf) {
    switch (tf) {
      case Timeframe.day:
        final start = DateTime(date.year, date.month, date.day);
        final end = start
            .add(Duration(days: 1))
            .subtract(const Duration(milliseconds: 1));
        return DateTimeRange(start: start, end: end);
      case Timeframe.week:
        final s = startOfWeek(date);
        final e = s
            .add(Duration(days: 7))
            .subtract(const Duration(milliseconds: 1));
        return DateTimeRange(start: s, end: e);
      case Timeframe.month:
        final s = DateTime(date.year, date.month, 1);
        final nextMonth = DateTime(date.year, date.month + 1, 1);
        final e = nextMonth.subtract(const Duration(milliseconds: 1));
        return DateTimeRange(start: s, end: e);
      case Timeframe.year:
        final s = DateTime(date.year, 1, 1);
        final e = DateTime(
          date.year + 1,
          1,
          1,
        ).subtract(const Duration(milliseconds: 1));
        return DateTimeRange(start: s, end: e);
    }
  }

  /// shift a date by -1 timeframe (to get previous period)
  DateTime shiftDateByPreviousPeriod(DateTime d, Timeframe tf) {
    switch (tf) {
      case Timeframe.day:
        return d.subtract(const Duration(days: 1));
      case Timeframe.week:
        return d.subtract(const Duration(days: 7));
      case Timeframe.month:
        return DateTime(d.year, d.month - 1, min(d.day, 28)); // safe approx
      case Timeframe.year:
        return DateTime(d.year - 1, d.month, d.day);
    }
  }

  /// Select a representative date for the "current period".
  DateTime representativeDate() {
    if (currentDateScore != null) return currentDateScore.date;
    // fallback: use latest score.date available
    final latest = scores.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    return latest.date;
  }

  DateTime repDate = representativeDate();
  final currentRange = periodRangeForDate(repDate, timeframe);
  final prevRange = periodRangeForDate(
    shiftDateByPreviousPeriod(repDate, timeframe),
    timeframe,
  );

  // Helper: filter scores to a range
  List<Score> scoresInRange(DateTimeRange r) => scores.where((s) {
    final sd = DateTime(s.date.year, s.date.month, s.date.day);
    return !sd.isBefore(DateTime(r.start.year, r.start.month, r.start.day)) &&
        !sd.isAfter(DateTime(r.end.year, r.end.month, r.end.day));
  }).toList();

  final List<String> insights = [];

  final availability = <_Metric>[];

  if (scoreType == ScoreType.activity || scoreType == ScoreType.health) {
    availability.addAll([
      _Metric(
        tr.activePoints,
        (s) => s.activePoints.toDouble(),
        tr.valueUnitPts,
        target: Score.activePointsTarget,
      ),
      _Metric(
        tr.steps,
        (s) => s.steps.toDouble(),
        tr.valueUnitSteps,
        target: Score.stepsTarget.toDouble(),
      ),
      _Metric(
        tr.moveHours,
        (s) => s.moveHours.toDouble(),
        tr.valueUnitH,
        target: Score.moveHoursTarget,
      ),
      _Metric(
        tr.activeCalories,
        (s) => s.activeCalories.toDouble(),
        tr.valueUnitKcal,
      ),
    ]);
  }
  if (scoreType == ScoreType.readiness || scoreType == ScoreType.health) {
    availability.addAll([
      _Metric(
        tr.sleep,
        (s) => s.sleepMinutes.toDouble(),
        tr.valueUnitH,
        targetRange: Score.sleepMinutesTargetRange,
      ),
      _Metric(
        tr.restingHR,
        (s) => s.restingHeartRateBpm.toDouble(),
        tr.valueUnitBpm,
        targetRange: Score.restingHeartRateBpmTargetRange,
      ),
      _Metric(
        tr.overnightHRV,
        (s) => s.overnightHeartRateVarianceMs.toDouble(),
        tr.valueUnitMs,
        target: Score.overnightHeartRateVarianceMsTarget,
      ),
    ]);
  }

  // For ScoreType.health we may also want high-level readiness/activity scores
  if (scoreType == ScoreType.health) {
    availability.addAll([
      _Metric(
        tr.readiness,
        (s) => s.readinessScore.toDouble(),
        tr.valueUnitPts,
      ),
      _Metric(tr.activity, (s) => s.activityScore.toDouble(), tr.valueUnitPts),
    ]);
  }

  // Format helpers (numbers -> localized strings). We must not use literal units here; use tr.* unit strings.
  String fmtRounded(double v, {int decimals = 0}) {
    if (decimals == 0) return v.round().toString();
    return v.toStringAsFixed(decimals);
  }

  String formatMetricValue(_Metric m, double value) {
    // Some metrics are stored in minutes (sleep) but shown as hours in UI — keep simple:
    if (m.label == tr.sleep) {
      // show hours with 1 decimal, convert minutes -> hours
      final hours = value / 60.0;
      return '${fmtRounded(hours, decimals: 1)} ${m.unit}';
    } else if (m.unit == tr.valueUnitPts) {
      return '${fmtRounded(value)} ${m.unit}';
    } else if (m.unit == tr.valueUnitH) {
      // moveHours is already in hours
      return '${fmtRounded(value, decimals: 1)} ${m.unit}';
    } else if (m.unit == tr.valueUnitSteps) {
      return '${fmtRounded(value)} ${m.unit}';
    } else if (m.unit == tr.valueUnitBpm ||
        m.unit == tr.valueUnitMs ||
        m.unit == tr.valueUnitKcal) {
      return '${fmtRounded(value)} ${m.unit}';
    } else {
      return '${fmtRounded(value)} ${m.unit}';
    }
  }

  // thresholds
  const double bigChangeThreshold = 0.15; // 15% = "big"
  const double trendThresholdPct = 0.05; // 5% considered small trend threshold
  const double variabilityThresholdRel =
      0.15; // 15% of mean => high variability

  // Now iterate metrics and produce insights
  for (final metric in availability) {
    // gather values in current and previous period
    final List<Score> curScores = scoresInRange(currentRange);
    final List<Score> prevScores = scoresInRange(prevRange);

    // If timeframe == day and a currentDateScore exists, prefer that single-point comparsion (yesterday vs today)
    double? curValue;
    if (timeframe == Timeframe.day && currentDateScore != null) {
      curValue = metric.getter(currentDateScore);
    } else {
      // compute average over current period
      final curVals = curScores
          .map((s) => metric.getter(s).toDouble())
          .toList();
      if (curVals.isNotEmpty) {
        curValue = mean(curVals);
      } else {
        // no data for this metric in current period -> skip
        continue;
      }
    }

    // previous period value (single or average)
    double? prevValue;
    if (timeframe == Timeframe.day) {
      // try to find the score for previous day
      final prevSingle = prevScores.isNotEmpty
          ? prevScores.firstWhere((_) => true, orElse: () => Score.zero())
          : null;
      if (prevScores.isNotEmpty) {
        prevValue = metric.getter(prevScores.first);
      } else {
        prevValue = null;
      }
    } else {
      final prevVals = prevScores
          .map((s) => metric.getter(s).toDouble())
          .toList();
      if (prevVals.isNotEmpty) prevValue = mean(prevVals);
    }

    // If we don't have current value, skip
    if (curValue == null) continue;

    final formattedCurValue = formatMetricValue(metric, curValue);

    // If prevValue exists -> comparison insight
    if (prevValue != null && prevValue.isFinite) {
      // handle infinite percent change if prevValue == 0
      final double pct = prevValue == 0
          ? (curValue == 0 ? 0.0 : double.infinity)
          : percentChange(prevValue, curValue);
      final bool improved = pct > 0.0;
      final bool bigChange = (pct.isFinite) && pct.abs() >= bigChangeThreshold;
      final String periodLabel;
      // pick a period label (yesterday / last week / last month / last year)
      switch (timeframe) {
        case Timeframe.day:
          periodLabel = tr.periodYesterday;
          break;
        case Timeframe.week:
          periodLabel = tr.periodLastWeek;
          break;
        case Timeframe.month:
          periodLabel = tr.periodLastMonth;
          break;
        case Timeframe.year:
          periodLabel = tr.periodLastYear;
          break;
      }

      if (pct == double.infinity) {
        // prev was zero and current positive -> special insight
        insights.add(
          tr.insightBetterThanPreviousPeriod(
            metric.label,
            formattedCurValue,
            tr.plusInfinity,
            periodLabel,
          ),
        );
      } else if (pct.abs() < 0.01) {
        // essentially no change
        insights.add(
          tr.insightNoChangeSincePreviousPeriod(
            metric.label,
            formattedCurValue,
            periodLabel,
          ),
        );
      } else {
        final pctText = (pct * 100).abs().round().toString();
        if (improved) {
          if (bigChange) {
            insights.add(
              tr.insightBigImprovement(
                metric.label,
                formattedCurValue,
                pctText,
                periodLabel,
              ),
            );
          } else {
            insights.add(
              tr.insightBetterThanPreviousPeriod(
                metric.label,
                formattedCurValue,
                pctText,
                periodLabel,
              ),
            );
          }
        } else {
          if (bigChange) {
            insights.add(
              tr.insightBigDrop(
                metric.label,
                formattedCurValue,
                pctText,
                periodLabel,
              ),
            );
          } else {
            insights.add(
              tr.insightWorseThanPreviousPeriod(
                metric.label,
                formattedCurValue,
                pctText,
                periodLabel,
              ),
            );
          }
        }
      }
    }

    // Trend analysis across ALL available scores for this metric (if enough samples)
    final allVals = scores
        .map((s) => metric.getter(s).toDouble())
        .where((v) => v.isFinite)
        .toList();
    if (allVals.length >= 3) {
      // determine simple trend: compare first-third average vs last-third average
      final n = allVals.length;
      final firstThird = allVals.sublist(0, max(1, (n / 3).floor()));
      final lastThird = allVals.sublist(max(1, (2 * n / 3).floor()), n);
      final double firstAvg = mean(firstThird);
      final double lastAvg = mean(lastThird);
      if (firstAvg > 0) {
        final double tPct = percentChange(firstAvg, lastAvg);
        if (tPct.isFinite) {
          if (tPct.abs() >= trendThresholdPct) {
            if (tPct > 0) {
              insights.add(tr.insightUpwardTrend(metric.label));
            } else {
              insights.add(tr.insightDownwardTrend(metric.label));
            }
          } else {
            insights.add(tr.insightStableTrend(metric.label));
          }
        }
      }
    }

    // Variability across period
    final List<double> periodVals =
        (timeframe == Timeframe.day && currentDateScore != null)
        ? (curValue != null ? [curValue] : [])
        : curScores
              .map((s) => metric.getter(s).toDouble())
              .where((v) => v.isFinite)
              .toList();

    if (periodVals.length >= 2) {
      final sd = stdDev(periodVals);
      final avg = mean(periodVals);
      if (avg > 0) {
        final rel = sd / avg;
        if (rel >= variabilityThresholdRel) {
          insights.add(
            tr.insightHighVariability(
              metric.label,
              fmtRounded(sd, decimals: 1),
            ),
          );
        } else {
          insights.add(tr.insightLowVariability(metric.label));
        }
      }
    }

    // Target checks (if target or targetRange exists)
    if (metric.targetRange != null) {
      final rv = curValue;
      final start = metric.targetRange!.start;
      final end = metric.targetRange!.end;
      if (rv >= start && rv <= end) {
        // special-case sleep to use a different message
        if (metric.label == tr.sleep) {
          insights.add(
            tr.insightSleepInTarget(formatMetricValue(metric, curValue)),
          );
        } else {
          insights.add(
            tr.insightTargetMet(
              metric.label,
              formatMetricValue(metric, curValue),
            ),
          );
        }
      } else {
        if (metric.label == tr.sleep) {
          if (rv < start) {
            insights.add(
              tr.insightSleepTooShort(formatMetricValue(metric, curValue)),
            );
          } else {
            insights.add(
              tr.insightSleepTooLong(formatMetricValue(metric, curValue)),
            );
          }
        } else {
          insights.add(
            tr.insightTargetNotMet(
              metric.label,
              formatMetricValue(metric, curValue),
            ),
          );
        }
      }
    } else if (metric.target != null) {
      final rv = curValue;
      final tgt = metric.target!;
      if (rv >= tgt) {
        insights.add(
          tr.insightTargetMet(
            metric.label,
            formatMetricValue(metric, curValue),
          ),
        );
      } else {
        final double shortByPct = percentChange(rv, tgt);
        insights.add(
          tr.insightTargetNotMet(
            metric.label,
            formatMetricValue(metric, curValue),
          ),
        );
      }
    }
  } // end for metrics

  if (insights.isEmpty) {
    return [tr.insightInsufficientData];
  }
  return insights;
}
