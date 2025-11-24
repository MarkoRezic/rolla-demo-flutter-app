import 'package:equatable/equatable.dart';

class ScoreActivity extends Equatable {
  final int id;
  final String category;
  final double durationSeconds;
  final double calories;

  const ScoreActivity({
    required this.id,
    required this.category,
    required this.durationSeconds,
    required this.calories,
  });

  @override
  List<Object?> get props => [id, category, durationSeconds, calories];
}
