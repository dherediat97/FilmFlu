part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required Map<int, List<MediaSimpleItemEntity>> movieData,
    required Map<int, List<MediaSimpleItemEntity>> serieData,
    required UiState uiState,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      movieData: {},
      serieData: {},
      uiState: UiState.initial(),
    );
  }
}
