import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';

abstract class MediaRepositoryContract {
  Future<Result<MediaItemEntity>> getMediaItem(
    String mediaType,
    int mediaTypeId,
  );
  Future<Result<CreditsMediaEntity>> getCredits(
    String mediaType,
    int mediaTypeId,
  );
}
