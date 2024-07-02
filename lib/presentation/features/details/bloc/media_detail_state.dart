part of 'media_detail_bloc.dart';

@freezed
class MediaDetailState with _$MediaDetailState {
  const factory MediaDetailState({
    MediaItemEntity? mediaItem,
    CreditsPersonEntity? credits,
    required UiState uiState,
  }) = _MediaDetailState;

  factory MediaDetailState.initial() {
    return const MediaDetailState(
      mediaItem: null,
      credits: null,
      uiState: UiState.initial(),
    );
  }
}
