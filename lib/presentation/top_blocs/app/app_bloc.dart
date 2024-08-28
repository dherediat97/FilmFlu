import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppLocalDataSourceContract _appLocalDataSourceContract;

  AppBloc({
    required AppLocalDataSourceContract appLocalDataSourceContract,
  })  : _appLocalDataSourceContract = appLocalDataSourceContract,
        super(AppState.initial()) {
    on<AppEvent>((event, emit) async {
      await event.when(
        changeLang: (String languageCode) =>
            _changeLang(event, emit, languageCode),
        changeStartLang: () => _changeStartLang(event, emit),
        toogleTheme: (bool isLightMode) =>
            _toggleTheme(event, emit, isLightMode),
      );
    });
  }

  Future<void> _changeStartLang(
    AppEvent event,
    Emitter<AppState> emit,
  ) async {
    String? langCode = await _appLocalDataSourceContract.getLanguage();
    emit(state.copyWith(locale: Locale(langCode.toString())));
  }

  Future<void> _changeLang(
    AppEvent event,
    Emitter<AppState> emit,
    String languageCode,
  ) async {
    emit(state.copyWith(locale: Locale(languageCode)));

    await _appLocalDataSourceContract.setLanguage(languageCode);
  }

  Future<void> _toggleTheme(
    AppEvent event,
    Emitter<AppState> emit,
    bool isLightMode,
  ) async {
    ThemeMode userThemeModeChosen =
        !isLightMode ? ThemeMode.dark : ThemeMode.light;

    TextTheme textTheme = createTextTheme(isLightMode: isLightMode);

    AppTheme theme = AppTheme(textTheme);

    emit(state.copyWith(
      themeMode: userThemeModeChosen,
      theme: theme,
    ));

    await _appLocalDataSourceContract.setThemeMode(userThemeModeChosen.name);
  }
}
