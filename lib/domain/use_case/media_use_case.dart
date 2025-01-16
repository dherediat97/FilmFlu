import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';

abstract class MediaUseCase {
  Future<MediaItemEntity> getMediaItem(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  );

  Future<CreditsMediaEntity?> getCredits(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  );

  Future<List<ReviewEntity>?> getReviews(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  );

  Future<MediaResponseEntity> getMedia(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  );

  // Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
  //   required MediaType mediaTypeSelected,
  //   required int genreId,
  //   required int page,
  // });

  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String languageId,
  );

  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
  );

  Future<List<MediaItemEntity>?> searchMediaData(
    MediaType mediaTypeSelected,
    String query,
  );

  Future<MediaItemEntity> getMediaDataDay(MediaType mediaTypeSelected);
}

class MediaUseCaseImpl extends MediaUseCase {
  final MediaRepository mediaRepository;

  MediaUseCaseImpl(this.mediaRepository);

  @override
  Future<MediaItemEntity> getMediaItem(
      MediaType mediaTypeSelected, String mediaTypeId) async {
    return mediaRepository.getMediaItem(mediaTypeSelected, mediaTypeId);
  }

  @override
  Future<CreditsMediaEntity?> getCredits(
      MediaType mediaTypeSelected, String mediaTypeId) async {
    return await mediaRepository.getCredits(mediaTypeSelected, mediaTypeId);
  }

  @override
  Future<List<ReviewEntity>?> getReviews(
      MediaType mediaTypeSelected, String mediaTypeId) async {
    return await mediaRepository.getReviews(mediaTypeSelected, mediaTypeId);
  }

  @override
  Future<MediaResponseEntity> getMedia(
      MediaType mediaTypeSelected, String mediaTypeId) async {
    return await mediaRepository.getMedia(mediaTypeSelected, mediaTypeId);
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
      MediaType mediaTypeSelected, int genreId, String languageId) async {
    return mediaTypeSelected == MediaType.movie
        ? getMovies(genreId, languageId)
        : getTVSeries(genreId, languageId);
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String languageId,
  ) async {
    final movieList = await mediaRepository.getMovies(
      genreId,
      languageId,
    );
    return movieList;
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
  ) async {
    final serieList = await mediaRepository.getTVSeries(
      genreId,
      languageId,
    );
    return serieList;
  }

  // @override
  // Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
  //   required MediaType mediaTypeSelected,
  //   required int genreId,
  //   required int page,
  // }) async {
  //   return await mediaListRepository.paginateMediaData(
  //     mediaTypeSelected: mediaTypeSelected,
  //     genreId: genreId,
  //     page: page,
  //   );
  // }

  @override
  Future<List<MediaItemEntity>?> searchMediaData(
    MediaType mediaTypeSelected,
    String query,
  ) async {
    return await mediaRepository.searchMediaData(mediaTypeSelected, query);
  }

  @override
  Future<MediaItemEntity> getMediaDataDay(MediaType mediaTypeSelected) async {
    return mediaRepository.getMediaDataDay(mediaTypeSelected);
  }
}
