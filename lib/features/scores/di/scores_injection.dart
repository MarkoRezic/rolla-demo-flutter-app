import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/features/scores/data/datasources/local_json_datasource.dart';
import 'package:rolla_demo_app/features/scores/data/repositories/score_repository_impl.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_earliest_score_date.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_scores.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/earliest_score_date_cubit.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/score_bloc.dart';

Future<void> initScores(GetIt sl) async {
  // Data sources
  sl.registerLazySingleton<LocalJsonDataSource>(
    () => LocalJsonDataSource(assetPath: 'assets/data/scores.json'),
  );
  // Repositories
  sl.registerLazySingleton<ScoreRepositoryImpl>(
    () => ScoreRepositoryImpl(dataSource: sl<LocalJsonDataSource>()),
  );
  // Use Cases
  final getScores = GetScores(repository: sl<ScoreRepositoryImpl>());
  final getEarliestScoreDate = GetEarliestScoreDate(
    repository: sl<ScoreRepositoryImpl>(),
  );
  // Blocs (factories)
  sl.registerFactory(() => ScoreBloc(getScores: getScores));
  sl.registerFactory(
    () => EarliestScoreDateCubit(getEarliestScoreDate: getEarliestScoreDate),
  );
}
