import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';

abstract class MediaRemoteDataSourceContract {
  Future<MediaItemRemoteEntity> getMediaDetail(
    String mediaType,
    int mediaTypeId,
  );
  Future<CreditsMediaRemoteEntity> getCredits(
    String mediaType,
    int mediaTypeId,
  );
}
