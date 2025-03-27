import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/repositories/media_repository_impl.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/enums/order_options.dart';
import 'package:film_flu/domain/enums/sort_options.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/models/search_result_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_repository.g.dart';

@riverpod
MediaRepository mediaRepository(ref) => MediaRepositoryImpl();

abstract interface class MediaRepository {
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  );

  Future<CreditsMediaEntity?> getCredits(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  );

  Future<List<ReviewEntity>> getReviews(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getSimilars(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
    int page,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    GenreIds genreId,
    String languageId,
    int page,
    SortOptions? sortBy,
    OrderOptions? orderBy,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    GenreIds genreId,
    String languageId,
    int page,
    String sortBy,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    GenreIds genreId,
    String languageId,
    int page,
    String sortBy,
  );

  Future<Pagination<SearchResultEntity>> searchMediaData(
    String languageName,
    String query,
  );

  Future<MediaItemEntity> getMediaDataDay(
    MediaType mediaTypeSelected,
    String languageCode,
  );
}
