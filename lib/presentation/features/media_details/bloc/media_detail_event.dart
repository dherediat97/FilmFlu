part of 'media_detail_bloc.dart';

@freezed
class MediaDetailEvent with _$MediaDetailEvent {
  const factory MediaDetailEvent.getMediaDetails(
    String mediaType,
    int mediaItemId,
  ) = _GetMediaDetails;

  const factory MediaDetailEvent.getCredits(
    String mediaType,
    int mediaItemId,
    bool isCast,
  ) = _GetCredits;

  const factory MediaDetailEvent.getReviews(
    String mediaType,
    int mediaItemId,
  ) = _GetReviews;

  const factory MediaDetailEvent.setCreditsType(
    bool isCastSelected,
  ) = _SetCreditsType;

  const factory MediaDetailEvent.openTrailer() = _OpenTrailer;

  const factory MediaDetailEvent.closeTrailer() = _CloseTrailer;
}
