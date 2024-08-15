part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.switchCategory(
    MediaType mediaTypeSelected,
  ) = _SwitchCategory;
}
