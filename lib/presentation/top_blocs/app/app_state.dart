part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required Locale locale,
    required bool isDarkMode,
    required AppTheme theme,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      locale: const Locale('es'),
      isDarkMode: true,
      theme: AppTheme(createTextTheme(isLightMode: false)),
    );
  }
}
