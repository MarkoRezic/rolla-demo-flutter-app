part of 'score_bloc.dart';

abstract class ScoreState {}

class ScoreInitial extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreLoaded extends ScoreState {
  final List<Score> scores;
  ScoreLoaded(this.scores);
}

class ScoreError extends ScoreState {
  final String message;
  ScoreError(this.message);
}
