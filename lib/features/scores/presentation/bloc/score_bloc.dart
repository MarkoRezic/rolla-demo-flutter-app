import 'package:bloc/bloc.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_scores.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final GetScores getScores;

  ScoreBloc({required this.getScores}) : super(ScoreInitial()) {
    on<LoadScoresEvent>(_onLoadScores);
  }

  Future<void> _onLoadScores(
    LoadScoresEvent event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    final res = await getScores.call(from: event.from, to: event.to);

    if (event.mockLoadingTime != null) {
      // Simulate loading time
      await Future.delayed(event.mockLoadingTime!);
    }
    res.fold(
      (failure) => emit(ScoreError(failure.message)),
      (records) => emit(ScoreLoaded(records)),
    );
  }
}
