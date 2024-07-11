part of 'media_list_bloc.dart';

@freezed
class MediaListEvent with _$MediaListEvent {
  const factory MediaListEvent.getMediaData() = _GetMediaData;
  const factory MediaListEvent.loadMoreMediaData(
    String mediaType,
    int page,
    int genreId,
  ) = _LoadMoreMediaData;
}
