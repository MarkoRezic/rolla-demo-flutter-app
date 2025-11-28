import 'package:intl/intl.dart';
import 'package:rolla_demo_app/features/scores/presentation/models/data_point.dart';

extension ListOfDataPointsToMapByDateKey on List<DataPoint> {
  Map<String, DataPoint?> get toMapByDateKey {
    final Map<String, DataPoint?> map = <String, DataPoint?>{};
    for (final DataPoint p in this) {
      final String key = DateFormat('yyyy-MM-dd').format(p.date);
      map[key] = p;
    }
    return map;
  }
}
