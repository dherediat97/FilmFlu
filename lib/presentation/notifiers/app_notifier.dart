import 'dart:ui';

import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends StateNotifier<AppState> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getBool('isDarkMode');
    state = state.copyWith(
      isDarkMode: darkMode ?? false,
      locale: const Locale('es'),
      theme: AppTheme(createTextTheme(isDarkMode: darkMode ?? false)),
    );
  }

  AppProvider() : super(AppState.initial()) {
    _init();
  }

  void toggle() async {
    final newDarkMode = !state.isDarkMode;
    state = state.copyWith(isDarkMode: newDarkMode);
    prefs.setBool('isDarkMode', newDarkMode);
  }
}

final appProvider = StateNotifierProvider<AppProvider, AppState>(
  (ref) => AppProvider(),
);

class AppState {
  final bool isDarkMode;
  final Locale locale;
  final AppTheme theme;

  AppState(
      {required this.isDarkMode, required this.locale, required this.theme});

  factory AppState.initial() {
    return AppState(
      isDarkMode: false,
      locale: const Locale('en'),
      theme: AppTheme(createTextTheme(isDarkMode: true)),
    );
  }

  AppState copyWith({bool? isDarkMode, Locale? locale, AppTheme? theme}) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
    );
  }
}
