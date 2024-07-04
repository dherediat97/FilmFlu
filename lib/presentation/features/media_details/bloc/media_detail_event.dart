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
  ) = _GetCredits;
}