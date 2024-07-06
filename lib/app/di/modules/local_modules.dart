part of '../di.dart';

final localModulesDi = GetIt.instance;

void _localModulesInit({required SharedPreferences instance}) {
  localModulesDi.registerLazySingleton<AppLocalDataSourceContract>(
    () => AppLocalDataSource(
      sharedPreferencesInstance: instance,
    ),
  );
}
