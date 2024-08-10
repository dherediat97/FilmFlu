part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required MediaType mediaTypeSelected,
  }) = _MediaDayState;

  factory HomeState.initial() {
    return const HomeState(
      mediaTypeSelected: MediaType.movie,
    );
  }
}
