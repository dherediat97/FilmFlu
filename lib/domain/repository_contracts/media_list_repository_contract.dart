import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';

abstract class MediaListRepositoryContract {
  Future<Result<List<MediaItemEntity>>> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  );

  Future<Result<List<MediaItemEntity>>> getMovies({
    required int genreId,
    String languageId,
  });

  Future<Result<List<MediaItemEntity>>> getTVSeries({
    required int genreId,
    String languageId,
  });

  Future<Result<List<MediaItemEntity>>> paginateMediaData({
    required MediaType mediaTypeSelected,
    required int page,
    required int genreId,
  });

  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  });

  Future<Result<MediaItemEntity>> getMediaDataDay({
    required MediaType mediaTypeSelected,
  });
}
