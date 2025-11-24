import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rolla_demo_app/features/scores/data/datasources/local_json_datasource.dart';
import 'package:rolla_demo_app/features/scores/data/repositories/score_repository_impl.dart';
import 'package:rolla_demo_app/features/scores/domain/usecases/get_scores.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/score_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());
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
  // Blocs (factories)
  sl.registerFactory(() => ScoreBloc(getScores: getScores));
}
