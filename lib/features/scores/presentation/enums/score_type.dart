import 'dart:ui';

import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

enum ScoreType {
  activity,
  readiness,
  health;

  Color get accentColor {
    switch (this) {
      case activity:
        return AppColors.green;
      case readiness:
        return AppColors.purple;
      case health:
        return AppColors.blue;
    }
  }

  String get scoreTitle {
    switch (this) {
      case activity:
        return tr.activity;
      case readiness:
        return tr.readiness;
      case health:
        return tr.healthScore;
    }
  }

  String get scoreInfoTitle {
    switch (this) {
      case activity:
        return tr.activityScore;
      case readiness:
        return tr.readinessScore;
      case health:
        return tr.healthScore;
    }
  }

  String get scoreDescription {
    switch (this) {
      case activity:
        return tr.scoreDescriptionActivity;
      case readiness:
        return tr.scoreDescriptionReadiness;
      case health:
        return tr.scoreDescriptionHealth;
    }
  }

  String get scoreMetricsDescription {
    switch (this) {
      case activity:
        return tr.scoreMetricsDescriptionActivity;
      case readiness:
        return tr.scoreMetricsDescriptionReadiness;
      case health:
        return tr.scoreMetricsDescriptionHealth;
    }
  }
}
