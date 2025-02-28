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
      isDarkMode: darkMode,
      theme: AppTheme(createTextTheme(isDarkMode: darkMode!)),
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
  final AppTheme theme;

  AppState({required this.isDarkMode, required this.theme});

  factory AppState.initial() {
    return AppState(
      isDarkMode: false,
      theme: AppTheme(createTextTheme(isDarkMode: true)),
    );
  }

  AppState copyWith({bool? isDarkMode, AppTheme? theme}) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      theme: theme ?? this.theme,
    );
  }
}
