part of '../di.dart';

final repositoryModulesDi = GetIt.instance;

void _repositoryModulesInit() {
  repositoryModulesDi.registerLazySingleton<MediaListRepositoryContract>(
    () => MediaListRepository(
      repositoryModulesDi(),
    ),
  );
  repositoryModulesDi.registerLazySingleton<MediaRepositoryContract>(
    () => MediaRepository(
      repositoryModulesDi(),
    ),
  );
  repositoryModulesDi.registerLazySingleton<PersonRepositoryContract>(
    () => PersonRepository(
      repositoryModulesDi(),
    ),
  );
}
