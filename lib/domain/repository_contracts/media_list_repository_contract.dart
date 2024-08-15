import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';

abstract class MediaListRepositoryContract {
  Future<Result<List<MediaSimpleItemEntity>>> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  );

  Future<Result<List<MediaSimpleItemEntity>>> getMovies({
    required int genreId,
    String languageId,
  });

  Future<Result<List<MediaSimpleItemEntity>>> getTVSeries({
    required int genreId,
    String languageId,
  });

  Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
    required MediaType mediaTypeSelected,
    required int page,
    required int genreId,
  });

  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  });

  Future<Result<MediaItemEntity?>> getMediaDataDay({
    required MediaType mediaTypeSelected,
  });
}
