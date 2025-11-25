import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

extension ListOfDataPointsToMapByDateKey on List<DataPoint> {
  Map<String, DataPoint?> get toMapByDateKey {
    final map = <String, DataPoint?>{};
    for (final p in this) {
      final key = DateFormat('yyyy-MM-dd').format(p.date);
      map[key] = p;
    }
    return map;
  }
}
