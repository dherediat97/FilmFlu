part of 'media_detail_bloc.dart';

@freezed
class MediaDetailState with _$MediaDetailState {
  const factory MediaDetailState({
    MediaItemEntity? mediaItem,
    required String movieName,
    required String trailerId,
    required String productionCompanyImage,
    List<ReviewEntity>? reviews,
    List<ActorEntity>? cast,
    List<FilmWorkerEntity>? crew,
    MediaResponseEntity? mediaList,
    required UiState uiState,
    required bool isTrailerOpened,
  }) = _MediaDetailState;

  factory MediaDetailState.initial() {
    return const MediaDetailState(
      mediaItem: null,
      movieName: '',
      trailerId: '',
      productionCompanyImage: '',
      cast: [],
      crew: [],
      reviews: [],
      mediaList: null,
      uiState: UiState.initial(),
      isTrailerOpened: false,
    );
  }
}
