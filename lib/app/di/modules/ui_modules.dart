part of '../di.dart';

final uiModulesDi = GetIt.instance;

void _uiModulesInit() {
  uiModulesDi.registerFactory(
    () => MediaListBloc(
      repositoryContract: uiModulesDi(),
    ),
  );
}
