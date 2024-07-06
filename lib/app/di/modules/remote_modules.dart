part of '../di.dart';

final remoteModulesDi = GetIt.instance;

void _remoteModulesInit() {
  remoteModulesDi.registerLazySingleton<MediaListRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi(), localModulesDi()),
  );
  remoteModulesDi.registerLazySingleton<MediaRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi(), localModulesDi()),
  );
  remoteModulesDi.registerLazySingleton<PersonRemoteDataSourceContract>(
    () => FilmFluRemoteDataSource(remoteModulesDi(), localModulesDi()),
  );
}
