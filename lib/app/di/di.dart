import 'package:film_flu/data/datasources/local/app_local_data_source.dart';
import 'package:film_flu/data/datasources/remote/filmflu_remote_data_source.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/data/repositories/person_repository.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/person_remote_data_source_contract.dart';
import 'package:film_flu/domain/repository/person_repository_contract.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'modules/local_modules.dart';
part 'modules/remote_modules.dart';
part 'modules/repository_modules.dart';
part 'modules/ui_modules.dart';

Future<void> initDi() async {
  _remoteModulesInit();
  _localModulesInit(instance: await SharedPreferences.getInstance());
  _repositoryModulesInit();
  _uiModulesInit();
}
