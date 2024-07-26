part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required List<MediaItemEntity>? movies,
    required List<MediaItemEntity>? series,
    required UiState uiState,
    required int pageLoaded,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      pageLoaded: 1,
      movies: [],
      series: [],
      uiState: UiState.initial(),
    );
  }
}
