import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/models/search_result_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';

abstract class MediaUseCase {
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
    String sortBy,
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

class MediaUseCaseImpl extends MediaUseCase {
  final MediaRepository mediaRepository;

  MediaUseCaseImpl(this.mediaRepository);

  @override
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  ) async {
    return mediaRepository.getMediaItem(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<CreditsMediaEntity?> getCredits(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  ) async {
    return await mediaRepository.getCredits(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getSimilars(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
    int page,
  ) async {
    return await mediaRepository.getSimilars(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
      page,
    );
  }

  @override
  Future<List<ReviewEntity>> getReviews(
    String mediaTypeSelected,
    int mediaTypeId,
    String languageName,
  ) async {
    return await mediaRepository.getReviews(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)>
  getMediaDataByGenre(
    MediaType mediaTypeSelected,
    GenreIds genreId,
    String languageId,
    int page,
    String sortBy,
  ) async {
    return mediaTypeSelected == MediaType.movie
        ? getMovies(genreId, languageId, page, sortBy)
        : getTVSeries(genreId, languageId, page, sortBy);
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getMovies(
    GenreIds genreId,
    String languageId,
    int page,
    String sortBy,
  ) async {
    final (currentPage, movieList) = await mediaRepository.getMovies(
      genreId,
      languageId,
      page,
      sortBy,
    );
    return (currentPage, movieList);
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    GenreIds genreId,
    String languageId,
    int page,
    String sortBy,
  ) async {
    final serieList = await mediaRepository.getTVSeries(
      genreId,
      languageId,
      page,
      sortBy,
    );
    return serieList;
  }

  @override
  Future<Pagination<SearchResultEntity>> searchMediaData(
    String languageName,
    String query,
  ) async {
    return await mediaRepository.searchMediaData(languageName, query);
  }

  @override
  Future<MediaItemEntity> getMediaDataDay(
    MediaType mediaTypeSelected,
    String languageCode,
  ) async {
    return mediaRepository.getMediaDataDay(mediaTypeSelected, languageCode);
  }
}
