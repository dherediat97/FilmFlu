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
    on<MediaListEvent>(
      (event, emit) async {
        await event.when(
          getMediaDataByGenre: (String mediaType, int genreId) =>
              _getMediaDataByGenreId(event, emit, genreId, mediaType),
          loadMoreMediaData: (String mediaType, int genreId) =>
              _loadMoreMediaData(event, emit, mediaType, genreId),
          nextPage: (int page) => _nextPage(event, emit, page),
        );
      },
    );
  }

  _getMediaDataByGenreId(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int genreId,
    String mediaType,
  ) async {
    emit(
      state.copyWith(
        uiState: const UiState.loading(),
      ),
    );
    try {
      final movieData =
          await _repository.getMediaDataByGenre(mediaType, genreId);
      movieData.when(
        failure: (errorMessage) {
          emit(
            state.copyWith(
              uiState: const UiState.error(),
            ),
          );
        },
        success: (value) {
          if (mediaType == MediaListConstants.movieMediaType) {
            emit(
              state.copyWith(
                uiState: const UiState.success(),
                movies: value
                    .where((element) => element.genreIds!.contains(genreId))
                    .toList(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                uiState: const UiState.success(),
                series: value
                    .where((element) => element.genreIds!.contains(genreId))
                    .toList(),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  _loadMoreMediaData(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    String mediaType,
    int genreId,
  ) async {
    final movieData = await _repository.paginateMediaData(
      mediaType: mediaType,
      page: state.pageLoaded,
      genreId: genreId,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
            mediaList: [],
          ),
        );
      },
      success: (value) => emit(
        state.copyWith(
          mediaList: value,
        ),
      ),
    );
  }

  _nextPage(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int page,
  ) async {
    emit(state.copyWith(pageLoaded: page++));
  }
}
