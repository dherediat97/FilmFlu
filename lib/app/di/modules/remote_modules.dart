part of '../di.dart';

final remoteModulesDi = GetIt.instance;

void _remoteModulesInit() {
  remoteModulesDi.registerLazySingleton<MediaListRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi()),
  );
  remoteModulesDi.registerLazySingleton<MediaRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi()),
  );
}
