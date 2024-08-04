part of 'media_day_bloc.dart';

@freezed
class MediaDayEvent with _$MediaDayEvent {
  const factory MediaDayEvent.fetchMovieDay() = _FetchMovieDay;
  const factory MediaDayEvent.fetchSerieDay() = _FetchSerieDay;
}
