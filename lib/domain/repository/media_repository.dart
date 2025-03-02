import 'package:film_flu/data/enums/genres_id.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/data/enums/order_options.dart';
import 'package:film_flu/data/enums/sort_options.dart';
import 'package:film_flu/data/repositories/media_repository_impl.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_repository.g.dart';

@riverpod
MediaRepository mediaRepository(ref) => MediaRepositoryImpl();

abstract interface class MediaRepository {
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<CreditsMediaEntity?> getCredits(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<List<ReviewEntity>> getReviews(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<MediaResponseEntity> getMedia(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    GenresId genreId,
    String languageId,
    int page,
    SortOptions? sortBy,
    OrderOptions? orderBy,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    GenresId genreId,
    String languageId,
    int page,
    String sortBy,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    GenresId genreId,
    String languageId,
    int page,
    String sortBy,
  );

  Future<List<MediaItemEntity>> searchMediaData(
    String languageName,
    String query,
  );

  Future<MediaItemEntity> getMediaDataDay(
    MediaType mediaTypeSelected,
    String languageCode,
  );
}
