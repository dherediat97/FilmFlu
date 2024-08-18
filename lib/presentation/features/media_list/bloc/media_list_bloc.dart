import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_list_event.dart';
part 'media_list_state.dart';
part 'media_list_bloc.freezed.dart';

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  final MediaListRepositoryContract _mediaListRepository;

  MediaListBloc({
    required MediaListRepositoryContract mediaListRepository,
  })  : _mediaListRepository = mediaListRepository,
        super(MediaListState.initial()) {
    on<MediaListEvent>(
      (event, emit) async {
        await event.when(
          getMediaDataByGenre: (categorySelected, genreId, languageId) =>
              _getMediaDataByGenreId(
                  event, emit, genreId, categorySelected, languageId),
          nextPage: (page, categorySelected, genreId) =>
              _nextPage(event, emit, page, categorySelected, genreId),
        );
      },
    );
  }

  Future<void> _getMediaDataByGenreId(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int genreId,
    MediaType mediaTypeSelected,
    String languageId,
  ) async {
    emit(state.copyWith(uiState: const UiState.loading()));
    final mediaData = await _mediaListRepository.getMediaDataByGenre(
      mediaTypeSelected,
      genreId,
      languageId,
    );
    mediaData.when(
      failure: (errorMessage) {
        emit(state.copyWith(uiState: const UiState.error()));
      },
      success: (value) {
        Map<int, List<MediaSimpleItemEntity>> movieData;
        Map<int, List<MediaSimpleItemEntity>> serieData;
        if (mediaTypeSelected == MediaType.movie) {
          movieData = {
            ...state.movieData,
            ...{genreId: value}
          };
          emit(state.copyWith(
            uiState: const UiState.success(),
            movieData: movieData,
          ));
        } else {
          serieData = {
            ...state.serieData,
            ...{genreId: value}
          };
          emit(state.copyWith(
            uiState: const UiState.success(),
            serieData: serieData,
          ));
        }
      },
    );
  }

  Future<void> _nextPage(
    MediaListEvent event,
    Emitter<MediaListState> emit,
    int page,
    MediaType mediaTypeSelected,
    int genreId,
  ) async {
    final mediaData = await _mediaListRepository.paginateMediaData(
      mediaTypeSelected: mediaTypeSelected,
      page: page,
      genreId: genreId,
    );
    mediaData.when(
      failure: (errorMessage) {
        emit(state.copyWith(uiState: const UiState.error()));
      },
      success: (value) {
        Map<int, List<MediaSimpleItemEntity>> movieData;
        Map<int, List<MediaSimpleItemEntity>> serieData;
        if (mediaTypeSelected == MediaType.movie) {
          movieData = {
            ...state.movieData,
            ...{genreId: value}
          };
          emit(state.copyWith(
            uiState: const UiState.success(),
            movieData: movieData,
          ));
        } else {
          serieData = {
            ...state.serieData,
            ...{genreId: value}
          };
          emit(state.copyWith(
            uiState: const UiState.success(),
            serieData: serieData,
          ));
        }
      },
    );
  }
}
