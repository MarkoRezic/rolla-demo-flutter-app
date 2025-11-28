part of 'score_bloc.dart';

abstract class ScoreEvent {}

class LoadScoresEvent extends ScoreEvent {

  LoadScoresEvent({this.from, this.to, this.mockLoadingTime});
  final DateTime? from;
  final DateTime? to;
  final Duration? mockLoadingTime;
}
