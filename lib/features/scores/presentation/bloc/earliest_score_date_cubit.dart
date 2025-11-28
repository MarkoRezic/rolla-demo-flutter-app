import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/error/failure.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_earliest_score_date.dart';

part 'earliest_score_date_state.dart';

class EarliestScoreDateCubit extends Cubit<EarliestScoreDateState> {
  EarliestScoreDateCubit({required this.getEarliestScoreDate})
    : super(EarliestScoreDateInitial());
  final GetEarliestScoreDate getEarliestScoreDate;

  DateTime? _cachedDate;
  bool _hasFetched = false;

  /// Fetch the earliest date only once. Subsequent calls return cached state immediately.
  Future<void> fetchOnce({DateTime? from, DateTime? to}) async {
    if (_hasFetched) {
      if (_cachedDate != null) {
        emit(EarliestScoreDateLoaded(_cachedDate));
      }
      return;
    }

    _hasFetched = true;
    emit(EarliestScoreDateLoading());

    final Either<Failure, DateTime?> res = await getEarliestScoreDate(
      from: from,
      to: to,
    );

    res.fold(
      (Failure failure) {
        emit(EarliestScoreDateError(failure.message));
      },
      (DateTime? date) {
        _cachedDate = date;
        emit(EarliestScoreDateLoaded(date));
      },
    );
  }

  void invalidateCache() {
    _cachedDate = null;
    _hasFetched = false;
    emit(EarliestScoreDateInitial());
  }

  DateTime? get cachedDate => _cachedDate;
}
