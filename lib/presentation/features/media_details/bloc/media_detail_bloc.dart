import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_detail_event.dart';
part 'media_detail_state.dart';
part 'media_detail_bloc.freezed.dart';

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  final MediaRepositoryContract _repository;

  MediaDetailBloc({
    required MediaRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(MediaDetailState.initial()) {
    on<MediaDetailEvent>((event, emit) async {
      await event.when(
        getMediaDetails: (String mediaType, int mediaItemId) =>
            _getMediaDetails(event, emit, mediaType, mediaItemId),
        getCredits: (String mediaType, int mediaItemId, bool isCast) =>
            _getCredits(event, emit, mediaType, mediaItemId, isCast),
        getReviews: (String mediaType, int mediaItemId) =>
            _getReviews(event, emit, mediaType, mediaItemId),
        setCreditsType: (bool isCastSelected) =>
            _setCreditsType(event, emit, isCastSelected),
        openTrailer: (String mediaType, MediaItemEntity mediaItem) =>
            _openTrailer(event, emit, mediaType, mediaItem),
        closeTrailer: () => _closeTrailer(event, emit),
      );
    });
  }

  Future<void> _getMediaDetails(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    int mediaItemId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaItem(
      mediaType: mediaType,
      mediaTypeId: mediaItemId,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (movie) {
        emit(state.copyWith(
          uiState: const UiState.success(),
          mediaItem: movie,
          trailerId: _getTrailerId(movie, mediaType),
          movieName: movie.title?.isNotEmpty == true
              ? movie.title.toString()
              : movie.name.toString(),
        ));
      },
    );
  }

  Future<void> _getCredits(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    int mediaTypeId,
    bool isCast,
  ) async {
    final creditsData = await _repository.getCredits(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
    );

    creditsData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (value) {
        emit(state.copyWith(uiState: const UiState.success(), credits: value));
      },
    );
  }

  Future<void> _getReviews(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    int mediaTypeId,
  ) async {
    final reviewList = await _repository.getReviews(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
    );
    reviewList.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (value) {
        if (value.isNotEmpty) {
          emit(
              state.copyWith(uiState: const UiState.success(), reviews: value));
        } else {
          emit(state.copyWith(reviews: null));
        }
      },
    );
  }

  Future<void> _setCreditsType(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    bool isCastSelected,
  ) async {
    emit(state.copyWith(isCastSelected: isCastSelected));
  }

  Future<void> _openTrailer(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaType,
    MediaItemEntity movie,
  ) async {
    emit(state.copyWith(
      isTrailerOpened: true,
    ));
  }

  Future<void> _closeTrailer(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
  ) async {
    emit(state.copyWith(
      isTrailerOpened: false,
    ));
  }

  String _getTrailerId(MediaItemEntity mediaItemEntity, String mediaType) {
    try {
      return mediaItemEntity.videos!.results
          .firstWhere((element) =>
              element.type == MediaListConstants.trailer ||
              element.type == MediaListConstants.teaser)
          .key
          .toString();
    } catch (ex) {
      return '';
    }
  }
}
