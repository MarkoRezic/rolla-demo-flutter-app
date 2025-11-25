import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/extensions/score/score_value_by_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

extension ScoreToDataPointByType on Score {
  DataPoint toDataPointByType(ScoreType scoreType) {
    return DataPoint(date, scoreValueByType(scoreType).toDouble());
  }
}
