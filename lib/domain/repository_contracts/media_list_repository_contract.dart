import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';

abstract class MediaListRepositoryContract {
  Future<Result<List<MediaItemEntity>>> getMediaDataByGenre(
    String mediaType,
    int genreId,
    String languageId,
  );

  Future<Result<List<MediaItemEntity>>> getMovies({
    required int genreId,
    String languageId = '',
  });

  Future<Result<List<MediaItemEntity>>> getTVSeries({
    required int genreId,
    String languageId = '',
  });

  Future<Result<List<MediaItemEntity>>> paginateMediaData({
    required String mediaType,
    required int page,
    required int genreId,
  });

  Future<Result<MediaItemEntity>> getMediaDataDay({
    required String mediaType,
  });
}
