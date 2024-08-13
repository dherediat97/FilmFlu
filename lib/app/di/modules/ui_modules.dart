part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  uiModulesDi.registerFactory(
    () => HomeBloc(
      repositoryContract: uiModulesDi(),
    ),
  );

  uiModulesDi.registerFactory(
    () => MediaListBloc(
      mediaListRepository: uiModulesDi(),
    ),
  );

  uiModulesDi.registerFactory(
    () => MediaDetailBloc(
      repositoryContract: uiModulesDi(),
    ),
  );
  uiModulesDi.registerFactory(
    () => PersonDetailsBloc(
      repositoryContract: uiModulesDi(),
    ),
  );
}
