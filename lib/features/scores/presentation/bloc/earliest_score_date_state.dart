part of 'earliest_score_date_cubit.dart';

abstract class EarliestScoreDateState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class EarliestScoreDateInitial extends EarliestScoreDateState {}

class EarliestScoreDateLoading extends EarliestScoreDateState {}

class EarliestScoreDateLoaded extends EarliestScoreDateState {
  EarliestScoreDateLoaded(this.date);
  final DateTime? date;

  @override
  List<Object?> get props => <Object?>[date];
}

class EarliestScoreDateError extends EarliestScoreDateState {
  EarliestScoreDateError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
