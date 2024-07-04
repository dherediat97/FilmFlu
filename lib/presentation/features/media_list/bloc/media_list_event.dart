part of 'media_list_bloc.dart';

@freezed
class MediaListEvent with _$MediaListEvent {
  const factory MediaListEvent.getMovieData() = _GetMovieData;
  const factory MediaListEvent.getTVSeriesData() = _GetTVSeriesData;
}
