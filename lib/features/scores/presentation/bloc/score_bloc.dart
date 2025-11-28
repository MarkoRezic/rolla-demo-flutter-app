import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_scores.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {

  ScoreBloc({required this.getScores}) : super(ScoreInitial()) {
    on<LoadScoresEvent>(_onLoadScores);
  }
  final GetScores getScores;

  Future<void> _onLoadScores(
    LoadScoresEvent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    final Either<Failure, List<Score>> res = await getScores.call(from: event.from, to: event.to);

    if (event.mockLoadingTime != null) {
      // Simulate loading time
      await Future.delayed(event.mockLoadingTime!);
    }
    res.fold(
      (Failure failure) => emit(ScoreError(failure.message)),
      (List<Score> records) => emit(ScoreLoaded(records)),
    );
  }
}
