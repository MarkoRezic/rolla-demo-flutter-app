import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/di/core_injection.dart';
import 'package:rolla_demo_app/features/scores/di/scores_injection.dart';

// Service locator
final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  await initCore(sl);
  await initScores(sl);
}
