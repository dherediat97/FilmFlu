import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';

abstract class MediaRemoteDataSourceContract {
  Future<MediaItemRemoteEntity> getMediaDetail({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  });

  Future<CreditsMediaRemoteEntity> getCredits({
    required MediaType mediaTypeSelected,
    required int mediaTypeId,
  });

  Future<Pagination<ReviewRemoteEntity>>? getReviews({
    required MediaType mediaTypeSelected,
    required int mediaTypeId,
  });
}
