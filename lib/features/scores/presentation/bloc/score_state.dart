part of 'score_bloc.dart';

abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreLoaded extends ScoreState {
  ScoreLoaded(this.scores);
  final List<Score> scores;
}

class ScoreError extends ScoreState {
  ScoreError(this.message);
  final String message;
}
