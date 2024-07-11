part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required List<MediaItemEntity> mediaList,
    required MediaDataEntity? mediaData,
    required UiState uiState,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      mediaList: [],
      mediaData: null,
      uiState: UiState.initial(),
    );
  }
}
