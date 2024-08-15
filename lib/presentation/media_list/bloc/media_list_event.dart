part of 'media_list_bloc.dart';

@freezed
class MediaListEvent with _$MediaListEvent {
  const factory MediaListEvent.getMediaDataByGenre(
    MediaType mediaType,
    int genreId,
    String languageId,
  ) = _GetMediaDataByGenre;

  const factory MediaListEvent.nextPage(
    int pageLoaded,
    MediaType categorySelected,
    int genreId,
  ) = _NextPage;
}
