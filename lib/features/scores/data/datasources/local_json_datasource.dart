import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/score_record.dart';

class LocalJsonDataSource {
  final String assetPath;

  LocalJsonDataSource({required this.assetPath});

  Future<List<ScoreRecord>> loadAll() async {
    final raw = await rootBundle.loadString(assetPath);
    final List<dynamic> list = json.decode(raw);
    return list
        .map((e) => ScoreRecord.fromJson({...Map<String, dynamic>.from(e)}))
        .toList();
  }
}
