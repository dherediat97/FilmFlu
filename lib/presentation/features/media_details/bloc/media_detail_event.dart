part of 'media_detail_bloc.dart';

@freezed
class MediaDetailEvent with _$MediaDetailEvent {
  const factory MediaDetailEvent.getMediaDetails(
    MediaType mediaType,
    String mediaItemId,
  ) = _GetMediaDetails;

  const factory MediaDetailEvent.getCredits(
    MediaType mediaTypeSelected,
    String mediaItemId,
    bool isCast,
  ) = _GetCredits;

  const factory MediaDetailEvent.getMedia(
    MediaType mediaType,
    String mediaItemId,
  ) = _GetMedia;

  const factory MediaDetailEvent.getReviews(
    MediaType mediaType,
    String mediaItemId,
  ) = _GetReviews;

  const factory MediaDetailEvent.openTrailer() = _OpenTrailer;

  const factory MediaDetailEvent.closeTrailer() = _CloseTrailer;
}
