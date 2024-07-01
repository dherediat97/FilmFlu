import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';

abstract class MovieRepositoryContract {
  Future<Result<List<MediaItemEntity>>> getMovies();
  Future<Result<List<MediaItemEntity>>> getTVSeries();
}
