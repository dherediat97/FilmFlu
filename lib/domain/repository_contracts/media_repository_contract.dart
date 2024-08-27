import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';

abstract class MediaRepositoryContract {
  Future<Result<MediaItemEntity>> getMediaItem({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<CreditsMediaEntity>> getCredits({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<List<ReviewEntity>?>> getReviews({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<Result<MediaResponseEntity>> getMedia({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });
}
