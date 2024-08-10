part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required Locale locale,
    required ThemeMode themeMode,
    required AppTheme theme,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      locale: const Locale('es'),
      themeMode: ThemeMode.dark,
      theme: AppTheme(createTextTheme(false)),
    );
  }
}
