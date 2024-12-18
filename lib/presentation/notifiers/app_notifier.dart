import 'dart:ui';

import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends StateNotifier<AppState> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getBool('isDarkMode');
    state.copyWith(
      isDarkMode: darkMode ?? false,
      locale: const Locale('es'),
      theme: AppTheme(createTextTheme(isLightMode: darkMode ?? false)),
    );
  }

  AppProvider() : super(AppState.initial()) {
    _init();
  }

  void toggle() async {
    state.copyWith(isDarkMode: !state.isDarkMode);
    prefs.setBool('isDarkMode', state.isDarkMode);
  }
}

final appProvider = StateNotifierProvider<AppProvider, AppState>(
  (ref) => AppProvider(),
);
