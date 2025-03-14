import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required bool isDarkMode,
    required AppTheme appTheme,
    required Locale appLocale,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      isDarkMode: false,
      appTheme: AppTheme(createTextTheme(isDarkMode: true)),
      appLocale: Locale('es'),
    );
  }
}
