part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required List<MediaItemEntity>? movieList,
    required List<MediaItemEntity>? tvSeriesList,
    required UiState uiState,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      movieList: [],
      tvSeriesList: [],
      uiState: UiState.initial(),
    );
  }
}
