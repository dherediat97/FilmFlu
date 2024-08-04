part of 'media_day_bloc.dart';

@freezed
class MediaDayState with _$MediaDayState {
  const factory MediaDayState({
    required UiState uiState,
    required MediaItemEntity? movie,
    required MediaItemEntity? serie,
  }) = _MediaDayState;

  factory MediaDayState.initial() {
    return const MediaDayState(
      uiState: UiState.initial(),
      movie: null,
      serie: null,
    );
  }
}
