part of 'earliest_score_date_cubit.dart';

abstract class EarliestScoreDateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EarliestScoreDateInitial extends EarliestScoreDateState {}

class EarliestScoreDateLoading extends EarliestScoreDateState {}

class EarliestScoreDateLoaded extends EarliestScoreDateState {
  final DateTime? date;
  EarliestScoreDateLoaded(this.date);

  @override
  List<Object?> get props => [date];
}

class EarliestScoreDateError extends EarliestScoreDateState {
  final String message;
  EarliestScoreDateError(this.message);

  @override
  List<Object?> get props => [message];
}
