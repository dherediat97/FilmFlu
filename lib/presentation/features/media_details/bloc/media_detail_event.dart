part of 'media_detail_bloc.dart';

@freezed
class MediaDetailEvent with _$MediaDetailEvent {
  const factory MediaDetailEvent.getMediaDetails(
    String mediaType,
    String mediaItemId,
  ) = _GetMediaDetails;

  const factory MediaDetailEvent.getCredits(
    String mediaType,
    int mediaItemId,
  ) = _GetCredits;

  const factory MediaDetailEvent.setCreditsType(
    bool isCastSelected,
  ) = _SetCreditsType;

  const factory MediaDetailEvent.openTrailer(
    String mediaType,
    MediaItemEntity mediaItem,
  ) = _OpenTrailer;

  const factory MediaDetailEvent.closeTrailer() = _CloseTrailer;
}
