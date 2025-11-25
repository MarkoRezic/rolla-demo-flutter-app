import 'package:flutter/material.dart';

enum Timeframe {
  day,
  week,
  month,
  year;

  String shortLabel(BuildContext context) {
    switch (this) {
      case Timeframe.day:
        return '1D';
      case Timeframe.week:
        return '7D';
      case Timeframe.month:
        return '30D';
      case Timeframe.year:
        return '1Y';
    }
  }
}
