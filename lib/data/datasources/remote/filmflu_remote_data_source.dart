import 'package:FilmFlu/data/datasources/remote/api/filmflu_api.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/movie_remote_data_source_contract.dart';

class FilmFluRemoteDataSource implements MovieRemoteDataSourceContract {
  final FilmFluApi _filmFluApi;

  FilmFluRemoteDataSource(this._filmFluApi);

  @override
  Future<List<MediaItemRemoteEntity>> getMovies() async {
    final mediaData = await _filmFluApi.fetchPopularMediaTypes('day', 'movie');
    return mediaData.results;
  }

  @override
  Future<List<MediaItemRemoteEntity>> getTVSeries() async {
    final mediaData = await _filmFluApi.fetchPopularMediaTypes('day', 'tv');
    return mediaData.results;
  }
}
