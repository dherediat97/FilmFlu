import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';
part 'language_cubit.freezed.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('es', 'ES'));

  void changeStartLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('LANGUAGE');

    emit(Locale(langCode.toString()));
  }

  void changeLang(context, String data) async {
    emit(Locale(data));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('LANGUAGE', data);
  }
}
