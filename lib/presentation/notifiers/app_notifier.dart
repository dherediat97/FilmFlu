import 'dart:ui';

import 'package:color_blindness/color_blindness.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:film_flu/presentation/notifiers/models/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends StateNotifier<AppState> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getBool(AppConstants.themeModeKey) ?? true;
    var appLanguage = prefs.getString(AppConstants.languageKey) ?? 'es';
    state = state.copyWith(
      isDarkMode: darkMode,
      appTheme: AppTheme(
        createTextTheme(isDarkMode: darkMode),
        ColorBlindnessType.none,
      ),
      appLocale: Locale(appLanguage),
    );
  }

  Future changeBlindessTheme(ColorBlindnessType colorBlindess) async {
    var prefs = await SharedPreferences.getInstance();
    if (state.appColorBlindessType != colorBlindess) {
      state = state.copyWith(
        appColorBlindessType: colorBlindess,
        appTheme: AppTheme(
          createTextTheme(isDarkMode: state.isDarkMode),
          colorBlindess,
        ),
      );
      await prefs.setString(AppConstants.colorBlindessType, colorBlindess.name);
    }
  }

  Future changeLanguage(Locale language) async {
    var prefs = await SharedPreferences.getInstance();
    if (state.appLocale != language) {
      state = state.copyWith(appLocale: language);
      await prefs.setString(AppConstants.languageKey, language.languageCode);
    }
  }

  AppProvider() : super(AppState.initial()) {
    _init();
  }

  void toggle() async {
    final newDarkMode = !state.isDarkMode;
    state = state.copyWith(isDarkMode: newDarkMode);
    prefs.setBool(AppConstants.themeModeKey, newDarkMode);
  }
}

final appProvider = StateNotifierProvider<AppProvider, AppState>(
  (ref) => AppProvider(),
);
