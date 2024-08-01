part of 'media_detail_bloc.dart';

@freezed
class MediaDetailState with _$MediaDetailState {
  const factory MediaDetailState({
    MediaItemEntity? mediaItem,
    required String movieName,
    required String trailerId,
    List<ReviewEntity>? reviews,
    List<ActorEntity>? cast,
    List<FilmWorkerEntity>? crew,
    required UiState uiState,
    required bool isCastSelected,
    required bool isTrailerOpened,
  }) = _MediaDetailState;

  factory MediaDetailState.initial() {
    return const MediaDetailState(
      mediaItem: null,
      movieName: '',
      trailerId: '',
      cast: [],
      crew: [],
      reviews: null,
      uiState: UiState.initial(),
      isCastSelected: true,
      isTrailerOpened: false,
    );
  }
}
