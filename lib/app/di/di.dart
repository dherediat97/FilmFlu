import 'package:FilmFlu/app/config/enviroment_config.dart';
import 'package:FilmFlu/app/constants/app_urls.dart';
import 'package:FilmFlu/data/datasources/remote/api/filmflu_api.dart';
import 'package:FilmFlu/data/datasources/remote/api/network/dio_http_client.dart';
import 'package:FilmFlu/data/datasources/remote/api/network/interceptors/curl_dio_interceptor.dart';
import 'package:FilmFlu/data/datasources/remote/filmflu_remote_data_source.dart';
import 'package:FilmFlu/data/repositories/media_list_repository.dart';
import 'package:FilmFlu/data/repositories/media_repository.dart';
import 'package:FilmFlu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:FilmFlu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:FilmFlu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:FilmFlu/domain/repository_contracts/media_repository_contract.dart';
import 'package:FilmFlu/presentation/features/details/bloc/media_detail_bloc.dart';
import 'package:FilmFlu/presentation/features/movie_list/bloc/media_list_bloc.dart';
import 'package:get_it/get_it.dart';

part 'modules/api_modules.dart';
part 'modules/remote_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

Future<void> initDi() async {
  _apiModulesInit();
  _remoteModulesInit();
  _repositoryModulesInit();
  _uiModulesInit();
}
