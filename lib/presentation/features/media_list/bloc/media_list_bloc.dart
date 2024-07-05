import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_list_event.dart';
part 'media_list_state.dart';
part 'media_list_bloc.freezed.dart';

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  final MediaListRepositoryContract _repository;

  MediaListBloc({
    required MediaListRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(MediaListState.initial()) {
    on<MediaListEvent>((event, emit) async {
      await event.when(
        getMovieData: (int genreId) => _getMovieData(event, emit, genreId),
        getTVSeriesData: (int genreId, String languageId) => _getTVSeriesData(
          event,
          emit,
          genreId,
          languageId,
        ),
      );
    });
  }

  _getMovieData(
      MediaListEvent event, Emitter<MediaListState> emit, genreId) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final movieData = await _repository.getMediaList(
      mediaType: MediaListConstants.movieMediaType,
      genreId: genreId,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error(), movieList: null),
        );
      },
      success: (value) => emit(
          state.copyWith(uiState: const UiState.success(), movieList: value)),
    );
  }

  _getTVSeriesData(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int genreId,
    String languageId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));

    final seriesData = await _repository.getMediaList(
      mediaType: MediaListConstants.serieMediaType,
      genreId: genreId,
      languageId: languageId,
    );
    seriesData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(uiState: const UiState.error(), tvSeriesList: null),
        );
      },
      success: (value) => emit(state.copyWith(
        uiState: const UiState.success(),
        tvSeriesList: value,
      )),
    );
  }
}
