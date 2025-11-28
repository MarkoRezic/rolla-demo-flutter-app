import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/domain/repositories/settings_repository.dart';
import 'package:rolla_demo_app/core/error/failure.dart';

class GetSettings {

  GetSettings({required this.repository});
  final SettingsRepository repository;

  Future<Either<Failure, Settings>> call() async {
    return await repository.getSettings();
  }
}
