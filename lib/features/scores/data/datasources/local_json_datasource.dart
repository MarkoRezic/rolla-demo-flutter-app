import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rolla_demo_app/features/scores/data/models/score_record.dart';

class LocalJsonDataSource {

  LocalJsonDataSource({required this.assetPath});
  final String assetPath;

  Future<List<ScoreRecord>> loadAll() async {
    final String raw = await rootBundle.loadString(assetPath);
    final List<dynamic> list = json.decode(raw);
    return list
        .map((e) => ScoreRecord.fromJson(<String, dynamic>{...Map<String, dynamic>.from(e)}))
        .toList();
  }
}
