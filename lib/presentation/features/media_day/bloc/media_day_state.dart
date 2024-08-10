part of 'media_day_bloc.dart';

@freezed
class MediaDayState with _$MediaDayState {
  const factory MediaDayState({
    required MediaType mediaTypeSelected,
    required UiState uiState,
    MediaItemEntity? mediaItem,
    required String mediaItemName,
  }) = _MediaDayState;

  factory MediaDayState.initial() {
    return const MediaDayState(
      mediaTypeSelected: MediaType.movie,
      uiState: UiState.initial(),
      mediaItem: null,
      mediaItemName: '',
    );
  }
}
