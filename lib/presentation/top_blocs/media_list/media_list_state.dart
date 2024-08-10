part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required MediaData? mediaData,
    required List<MediaItemEntity> mediaSearchedList,
    required UiState uiState,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      mediaData: null,
      mediaSearchedList: [],
      uiState: UiState.initial(),
    );
  }
}

@freezed
class MediaData with _$MediaData {
  const factory MediaData({
    required Map<int, List<MediaItemEntity>> movieDataByGenre,
    required Map<int, List<MediaItemEntity>> serieDataByGenre,
  }) = _MovieData;
}
