part of '../di.dart';

final apiModulesDi = GetIt.instance;

void _apiModulesInit() {
  apiModulesDi.registerLazySingleton(() {
    var dioClient = DioClient();

    dioClient.addInterceptors([
      ...EnvironmentConfig.environment == 'dev'
          ? [CurlLoggerDioInterceptor(printOnSuccess: false)]
          : [],
    ]);

    return dioClient.getDio();
  });

  apiModulesDi.registerLazySingleton(
    () => FilmFluApi(
      apiModulesDi(),
      baseUrl: AppUrls.baseUrl,
    ),
  );
}
