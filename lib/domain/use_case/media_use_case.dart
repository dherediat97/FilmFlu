import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';

abstract class MediaUseCase {
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    String mediaTypeId,
    String? languageName,
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
    int genreId,
    String languageId,
    int page,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String languageId,
    int page,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
    int page,
  );

  Future<List<MediaItemEntity>> searchMediaData(
    String languageName,
    String query,
  );

  Future<MediaItemEntity> getMediaDataDay(MediaType mediaTypeSelected);
}

class MediaUseCaseImpl extends MediaUseCase {
  final MediaRepository mediaRepository;

  MediaUseCaseImpl(this.mediaRepository);

  @override
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    String mediaTypeId,
    String? languageName,
  ) async {
    return mediaRepository.getMediaItem(
      mediaTypeSelected,
      mediaTypeId,
      languageName ?? 'en',
    );
  }

  @override
  Future<CreditsMediaEntity?> getCredits(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    return await mediaRepository.getCredits(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<List<ReviewEntity>> getReviews(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    return await mediaRepository.getReviews(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<MediaResponseEntity> getMedia(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    return await mediaRepository.getMedia(
      mediaTypeSelected,
      mediaTypeId,
      languageName,
    );
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)>
      getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
    int page,
  ) async {
    return mediaTypeSelected == MediaType.movie
        ? getMovies(genreId, languageId, page)
        : getTVSeries(genreId, languageId, page);
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String languageId,
    int page,
  ) async {
    final (currentPage, movieList) = await mediaRepository.getMovies(
      genreId,
      languageId,
      page,
    );
    return (currentPage, movieList);
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
    int page,
  ) async {
    final serieList = await mediaRepository.getTVSeries(
      genreId,
      languageId,
      page,
    );
    return serieList;
  }

  @override
  Future<List<MediaItemEntity>> searchMediaData(
    String languageName,
    String query,
  ) async {
    return await mediaRepository.searchMediaData(languageName, query);
  }

  @override
  Future<MediaItemEntity> getMediaDataDay(MediaType mediaTypeSelected) async {
    return mediaRepository.getMediaDataDay(mediaTypeSelected);
  }
}
