part of 'score_bloc.dart';

abstract class ScoreEvent {}

class LoadScoresEvent extends ScoreEvent {
  final DateTime? from;
  final DateTime? to;

  LoadScoresEvent({this.from, this.to});
}
