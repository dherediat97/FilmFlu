part of 'media_list_bloc.dart';

@freezed
class MediaListEvent with _$MediaListEvent {
  const factory MediaListEvent.getMovieData(int genre) = _GetMovieData;
  const factory MediaListEvent.getTVSeriesData(int genre, String languageId) =
      _GetTVSeriesData;
}
