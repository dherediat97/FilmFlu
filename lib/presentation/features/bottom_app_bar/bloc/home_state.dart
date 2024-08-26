part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required MediaType mediaTypeSelected,
    required UiState uiState,
    required MediaItemEntity? mediaItem,
    required bool isHomeScreen,
  }) = _MediaDayState;

  factory HomeState.initial() {
    return const HomeState(
      mediaTypeSelected: MediaType.movie,
      uiState: UiState.initial(),
      mediaItem: null,
      isHomeScreen: false,
    );
  }
}
