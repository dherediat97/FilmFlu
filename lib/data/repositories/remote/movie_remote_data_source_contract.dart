import 'package:FilmFlu/data/models/media_item_remote_entity.dart';

abstract class MovieRemoteDataSourceContract {
  Future<List<MediaItemRemoteEntity>> getMovies();
  Future<List<MediaItemRemoteEntity>> getTVSeries();
}
