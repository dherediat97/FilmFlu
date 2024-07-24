import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';

abstract class MediaRepositoryContract {
  Future<Result<MediaItemEntity>> getMediaItem({
    required String mediaType,
    required int mediaTypeId,
  });

  Future<Result<CreditsMediaEntity>> getCredits({
    required String mediaType,
    required int mediaTypeId,
  });

  Future<Result<List<ReviewEntity>>> getReviews({
    required String mediaType,
    required int mediaTypeId,
  });
}
