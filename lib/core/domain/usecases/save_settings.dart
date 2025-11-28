import 'package:dartz/dartz.dart';
import 'package:rolla_demo_app/core/domain/entitites/settings.dart';
import 'package:rolla_demo_app/core/domain/repositories/settings_repository.dart';
import 'package:rolla_demo_app/core/error/failure.dart';

class SaveSettings {
  final SettingsRepository repository;

  SaveSettings({required this.repository});

  Future<Either<Failure, Settings>> call({required Settings settings}) async {
    return await repository.saveSettings(settings);
  }
}
