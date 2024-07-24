import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';

abstract class MediaRemoteDataSourceContract {
  Future<MediaItemRemoteEntity> getMediaDetail({
    required String mediaType,
    required int mediaTypeId,
  });

  Future<CreditsMediaRemoteEntity> getCredits({
    required String mediaType,
    required int mediaTypeId,
  });

  Future<Pagination<ReviewRemoteEntity>>? getReviews({
    required String mediaType,
    required int mediaTypeId,
  });
}
