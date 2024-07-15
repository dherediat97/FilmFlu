import 'package:film_flu/app/config/enviroment_config.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/data/datasources/local/app_local_data_source.dart';
import 'package:film_flu/data/datasources/remote/api/filmflu_api.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_http_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/interceptors/curl_dio_interceptor.dart';
import 'package:film_flu/data/datasources/remote/filmflu_remote_data_source.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/data/repositories/media_list_repository.dart';
import 'package:film_flu/data/repositories/media_repository.dart';
import 'package:film_flu/data/repositories/person_repository.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/person_remote_data_source_contract.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';
import 'package:film_flu/domain/repository_contracts/person_repository_contract.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:film_flu/presentation/top_blocs/language_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'modules/local_modules.dart';
part 'modules/api_modules.dart';
part 'modules/remote_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

Future<void> initDi() async {
  _apiModulesInit();
  _remoteModulesInit();
  _localModulesInit(instance: await SharedPreferences.getInstance());
  _repositoryModulesInit();
  _uiModulesInit();
}
