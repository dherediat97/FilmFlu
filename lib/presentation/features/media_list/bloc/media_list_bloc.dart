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
          getMediaDataByGenre:
              (String mediaType, int genreId, String languageId) =>
                  _getMediaDataByGenreId(
                      event, emit, genreId, mediaType, languageId),
          loadMoreMediaData: (String mediaType, int genreId) =>
              _loadMoreMediaData(event, emit, mediaType, genreId),
          nextPage: (int page) => _nextPage(event, emit, page),
        );
      },
    );
  }

  Future<void> _getMediaDataByGenreId(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int genreId,
    String mediaType,
    String languageId,
  ) async {
    emit(
      state.copyWith(
        uiState: const UiState.loading(),
      ),
    );
    final movieData =
        await _repository.getMediaDataByGenre(mediaType, genreId, languageId);
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
          ),
        );
      },
      success: (mediaDataList) {
        MediaListConstants.mediaData.addAll({genreId: mediaDataList});
        emit(state.copyWith(mediaData: MediaListConstants.mediaData));
      },
    );
  }

  Future<void> _loadMoreMediaData(
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
          ),
        );
      },
      success: (value) => emit(
        state.copyWith(),
      ),
    );
  }

  Future<void> _nextPage(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int page,
  ) async {
    emit(state.copyWith(pageLoaded: page++));
  }
}
