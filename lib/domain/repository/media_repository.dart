import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/data/repositories/media_repository_impl.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_repository.g.dart';

@riverpod
MediaRepository mediaRepository(ref) => MediaRepositoryImpl();

abstract interface class MediaRepository {
  Future<MediaItemEntity> getMediaItem(
    MediaType mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<CreditsMediaEntity?> getCredits(
    MediaType mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<List<ReviewEntity>?> getReviews(
    MediaType mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<MediaResponseEntity> getMedia(
    MediaType mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String languageId,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
  );

  Future<List<MediaItemEntity>> searchMediaData(
    String languageName,
    String query,
  );

  Future<MediaItemEntity> getMediaDataDay(
    MediaFilter mediaFilter,
  );
}
