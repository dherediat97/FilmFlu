import 'dart:ui';

import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.dart';
part 'language_cubit.freezed.dart';

class LanguageCubit extends Cubit<Locale> {
  final AppLocalDataSourceContract _appLocalDataSourceContract;

  LanguageCubit({
    required AppLocalDataSourceContract appLocalDataSourceContract,
  })  : _appLocalDataSourceContract = appLocalDataSourceContract,
        super(const Locale('es'));

  void changeStartLang() async {
    String? langCode = await _appLocalDataSourceContract.getLanguage();

    emit(Locale(langCode.toString()));
  }

  void changeLang(context, String data) async {
    emit(Locale(data));

    await _appLocalDataSourceContract.setLanguage(data);
  }
}
