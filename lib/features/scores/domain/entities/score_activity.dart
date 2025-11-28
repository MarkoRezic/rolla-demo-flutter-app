import 'package:equatable/equatable.dart';

class ScoreActivity extends Equatable {

  const ScoreActivity({
    required this.id,
    required this.category,
    required this.durationSeconds,
    required this.calories,
  });
  final int id;
  final String category;
  final double durationSeconds;
  final double calories;

  @override
  List<Object?> get props => <Object?>[id, category, durationSeconds, calories];
}
