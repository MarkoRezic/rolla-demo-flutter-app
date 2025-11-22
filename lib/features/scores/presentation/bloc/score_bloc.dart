import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/score_repository_impl.dart';
import '../../domain/entities/score.dart';
import '../../domain/usecases/get_scores.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepositoryImpl repository;

  ScoreBloc({required this.repository}) : super(ScoreInitial()) {
    on<LoadScoresEvent>(_onLoadScores);
  }

  Future<void> _onLoadScores(
      LoadScoresEvent event, Emitter<ScoreState> emit) async {
    emit(ScoreLoading());
    final res = await repository.getScores(
        type: event.type, from: event.from, to: event.to);
    res.fold((failure) {
      emit(ScoreError(failure.message));
    }, (records) {
      emit(ScoreLoaded(records));
    });
  }
}
