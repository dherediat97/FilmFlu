part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.changeStartLang() = _ChangeStartLang;

  const factory AppEvent.changeLang(String languageCode) = _ChangeLang;

  const factory AppEvent.toogleTheme(
    bool isLightMode,
  ) = _ToggleTheme;
}
