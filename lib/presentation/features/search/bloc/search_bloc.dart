import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MediaListRepositoryContract _repository;

  SearchBloc({
    required MediaListRepositoryContract repositoryContract,
  })  : _repository = repositoryContract,
        super(SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      await event.when(
        addMovieFilters: (movieFilters) => _addMovieFilters(
          event,
          emit,
          movieFilters,
        ),
        addSerieFilters: (serieFilters) => _addSerieFilters(
          event,
          emit,
          serieFilters,
        ),
        searchMovie: (movieFilters, query) => _searchMovie(
          event,
          emit,
          movieFilters ?? const MovieFilters(),
          query,
        ),
        searchSerie: (serieFilters, query) => _searchSerie(
          event,
          emit,
          serieFilters ?? const SerieFilters(),
          query,
        ),
      );
    });
  }

  Future<void> _addMovieFilters(
    SearchEvent event,
    Emitter<SearchState> emit,
    MovieFilters movieFilters,
  ) async {
    emit(state.copyWith(
      movieFilters: movieFilters,
    ));
  }

  Future<void> _addSerieFilters(
    SearchEvent event,
    Emitter<SearchState> emit,
    SerieFilters serieFilters,
  ) async {
    emit(state.copyWith(
      serieFilters: serieFilters,
    ));
  }

  Future<void> _searchMovie(
    SearchEvent event,
    Emitter<SearchState> emit,
    MovieFilters movieFilters,
    String query,
  ) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final movieData = await _repository.searchMediaData(
      mediaTypeSelected: MediaType.movie,
      query: query,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
            mediaSearchedList: [],
          ),
        );
      },
      success: (value) {
        emit(
          state.copyWith(
            mediaSearchedList: value,
            uiState: const UiState.success(),
          ),
        );
      },
    );
  }

  Future<void> _searchSerie(
    SearchEvent event,
    Emitter<SearchState> emit,
    SerieFilters movieFilters,
    String query,
  ) async {
    Future.delayed(const Duration(milliseconds: 2000));
    final movieData = await _repository.searchMediaData(
      mediaTypeSelected: MediaType.tv,
      query: query,
    );
    movieData.when(
      failure: (errorMessage) {
        emit(
          state.copyWith(
            uiState: const UiState.error(),
            mediaSearchedList: [],
          ),
        );
      },
      success: (value) {
        emit(
          state.copyWith(
            mediaSearchedList: value,
            uiState: const UiState.success(),
          ),
        );
      },
    );
  }
}
