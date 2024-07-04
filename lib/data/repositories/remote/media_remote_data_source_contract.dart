import 'package:FilmFlu/data/models/credits_media_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';

abstract class MediaRemoteDataSourceContract {
  Future<MediaItemRemoteEntity> getMediaDetail(
    String mediaType,
    String mediaTypeId,
  );
  Future<CreditsMediaRemoteEntity> getCredits(
    String mediaType,
    String mediaTypeId,
  );
}
