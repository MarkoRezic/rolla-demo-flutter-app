part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  SettingsLoaded(this.settings);
  final Settings settings;

  @override
  List<Object?> get props => <Object?>[settings];
}

class SettingsError extends SettingsState {
  SettingsError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
