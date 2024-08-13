import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/actor_entity.dart';
import 'package:film_flu/domain/models/film_worker_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
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
        getMediaDetails: (mediaType, mediaItemId) =>
            _getMediaDetails(event, emit, mediaType, mediaItemId),
        getCredits: (mediaType, mediaItemId, isCast) =>
            _getCredits(event, emit, mediaType, mediaItemId, isCast),
        getReviews: (mediaType, mediaItemId) =>
            _getReviews(event, emit, mediaType, mediaItemId),
        setCreditsType: (isCastSelected) =>
            _setCreditsType(event, emit, isCastSelected),
        openTrailer: () => _openTrailer(event, emit),
        closeTrailer: () => _closeTrailer(event, emit),
        clearState: () => _clearState(event, emit),
      );
    });
  }

  Future<void> _getMediaDetails(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    String mediaTypeSelected,
    String mediaItemId,
  ) async {
    _clearState(event, emit);
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaItem(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaItemId,
    );

    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (movie) {
        emit(
          state.copyWith(
            uiState: const UiState.success(),
            mediaItem: movie,
            trailerId: _getTrailerId(movie),
            productionCompanyImage:
                movie.productionCompanies?.firstOrNull?.logoPath ?? '',
            movieName: movie.title?.isNotEmpty == true
                ? movie.title.toString()
                : movie.name.toString(),
          ),
        );
      },
    );
  }

  Future<void> _getCredits(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    MediaType mediaTypeSelected,
    int mediaTypeId,
    bool isCast,
  ) async {
    final creditsData = await _repository.getCredits(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );

    creditsData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
          ),
        );
      },
      success: (value) {
        if (isCast) {
          emit(
            state.copyWith(
              uiState: const UiState.success(),
              cast: value.cast,
            ),
          );
        } else {
          emit(
            state.copyWith(
              uiState: const UiState.success(),
              crew: value.crew,
            ),
          );
        }
      },
    );
  }

  Future<void> _getReviews(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
    MediaType mediaTypeSelected,
    int mediaTypeId,
  ) async {
    final reviewResponseData = await _repository.getReviews(
      mediaTypeSelected: mediaTypeSelected,
      mediaTypeId: mediaTypeId,
    );
    reviewResponseData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error()),
        );
      },
      success: (reviewList) {
        emit(
          state.copyWith(
            uiState: reviewList != null
                ? const UiState.success()
                : const UiState.error(),
            reviews: reviewList ?? [],
          ),
        );
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
  ) async {
    emit(
      state.copyWith(
        isTrailerOpened: true,
      ),
    );
  }

  Future<void> _closeTrailer(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        isTrailerOpened: false,
      ),
    );
  }

  String _getTrailerId(MediaItemEntity mediaItemEntity) {
    try {
      return mediaItemEntity.videos!.results
          .firstWhere((element) =>
              element.type == AppConstants.trailer ||
              element.type == AppConstants.teaser)
          .key
          .toString();
    } catch (ex) {
      return '';
    }
  }

  _clearState(
    MediaDetailEvent event,
    Emitter<MediaDetailState> emit,
  ) async* {
    yield state;
  }
}
