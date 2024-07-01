part of '../di.dart';

final remoteModulesDi = GetIt.instance;

void _remoteModulesInit() {
  remoteModulesDi.registerLazySingleton<MovieRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi()),
  );
}
