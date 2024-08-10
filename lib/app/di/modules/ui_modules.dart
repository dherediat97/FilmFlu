part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  uiModulesDi.registerFactory(
    () => HomeBloc(),
  );

  uiModulesDi.registerFactory(
    () => MediaDayBloc(
      repositoryContract: uiModulesDi(),
    ),
  );

  uiModulesDi.registerFactory(
    () => MediaListBloc(
      repositoryContract: uiModulesDi(),
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
