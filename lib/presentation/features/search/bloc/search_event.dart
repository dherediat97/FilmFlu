part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.addMovieFilters(MovieFilters movieFilters) =
      _AddMovieFilters;
  const factory SearchEvent.addSerieFilters(SerieFilters seriefilters) =
      _AddSerieFilters;

  const factory SearchEvent.searchMovie({
    MovieFilters? movieFilters,
    required String query,
  }) = _SearchMovie;

  const factory SearchEvent.searchSerie({
    SerieFilters? seriefilters,
    required String query,
  }) = _SearchSerie;
}
