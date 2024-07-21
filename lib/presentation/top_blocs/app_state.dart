part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required Locale locale,
    required ThemeMode themeMode,
  }) = _AppState;

  factory AppState.initial() {
    return const AppState(
      locale: Locale('es'),
      themeMode: ThemeMode.dark,
    );
  }
}
