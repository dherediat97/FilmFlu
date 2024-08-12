part of 'media_list_bloc.dart';

@freezed
class MediaListState with _$MediaListState {
  const factory MediaListState({
    required MediaData? mediaData,
    required UiState uiState,
  }) = _MediaListState;

  factory MediaListState.initial() {
    return const MediaListState(
      mediaData: null,
      uiState: UiState.initial(),
    );
  }
}

@freezed
class MediaData with _$MediaData {
  const factory MediaData({
    required Map<int, List<MediaSimpleItemEntity>>? movieDataByGenre,
    required Map<int, List<MediaSimpleItemEntity>>? serieDataByGenre,
  }) = _MovieData;
}
