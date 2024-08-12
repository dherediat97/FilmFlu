part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    UiState? uiState,
    MovieFilters? movieFilters,
    SerieFilters? serieFilters,
    required List<MediaItemEntity> mediaSearchedList,
  }) = _SearchState;

  factory SearchState.initial() {
    return const SearchState(
      uiState: UiState.initial(),
      movieFilters: null,
      serieFilters: null,
      mediaSearchedList: [],
    );
  }
}

@freezed
class MovieFilters with _$MovieFilters {
  const factory MovieFilters({
    bool? isActionMovieFiltered,
  }) = _MovieFilters;
}

@freezed
class SerieFilters with _$SerieFilters {
  const factory SerieFilters({
    bool? isActionSeriesFiltered,
  }) = _SerieFilters;
}
