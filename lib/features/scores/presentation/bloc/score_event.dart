part of 'score_bloc.dart';

abstract class ScoreEvent {}

class LoadScoresEvent extends ScoreEvent {
  final String? type;
  final DateTime? from;
  final DateTime? to;

  LoadScoresEvent({this.type, this.from, this.to});
}
