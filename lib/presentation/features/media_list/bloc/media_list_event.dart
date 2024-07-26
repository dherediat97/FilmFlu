part of 'media_list_bloc.dart';

@freezed
class MediaListEvent with _$MediaListEvent {
  const factory MediaListEvent.getMediaDataByGenre(
    String mediaType,
    int genreId,
  ) = _GetMediaDataByGenre;

  const factory MediaListEvent.loadMoreMediaData(
    String mediaType,
    int genreId,
  ) = _LoadMoreMediaData;

  const factory MediaListEvent.nextPage(int pageLoaded) = _NextPage;
}
