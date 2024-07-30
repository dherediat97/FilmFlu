part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required Map<int, List<MediaItemEntity>> mediaData,
    required UiState uiState,
    required int pageLoaded,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      pageLoaded: 1,
      mediaData: {},
      uiState: UiState.initial(),
    );
  }
}
