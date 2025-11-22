import 'package:equatable/equatable.dart';

class Score extends Equatable {
  final String id;
  final String type;
  final DateTime timestamp;
  final int score;
  final Map<String, dynamic> metrics;

  const Score({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.score,
    required this.metrics,
  });

  @override
  List<Object?> get props => [id, type, timestamp, score, metrics];
}
