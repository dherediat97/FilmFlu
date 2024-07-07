import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/models/genre_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/domain/models/media_data_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';

class MediaListRepository implements MediaListRepositoryContract {
  final MediaListRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaListRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<MediaDataEntity>> getMediaData() async {
    try {
      List<GenreEntity> genreMovieList =
          await getGenreList(MediaListConstants.movieMediaType);
      List<GenreEntity> genreTvList =
          await getGenreList(MediaListConstants.serieMediaType);

      return Result.success(MediaDataEntity(
        fictionMovies: await getMovies(
            genre: genreMovieList
                .firstWhere(
                    (element) => element.name.contains('Science Fiction'))
                .id),
        dramasMovies: await getMovies(
            genre: genreMovieList
                .firstWhere((element) => element.name.contains('Drama'))
                .id),
        actionMovies: await getMovies(
            genre: genreMovieList
                .firstWhere((element) => element.name.contains('Action'))
                .id),
        romanceMovies: await getMovies(
            genre: genreMovieList
                .firstWhere((element) => element.name.contains('Romance'))
                .id),
        comedyMovies: await getMovies(
            genre: genreMovieList
                .firstWhere((element) => element.name.contains('Comedy'))
                .id),
        suspenseMovies: await getMovies(
            genre: genreMovieList
                .firstWhere((element) => element.name.contains('Thriller'))
                .id),
        animeSeries: await getTVSeries(
          genre: genreTvList
              .firstWhere((element) => element.name.contains('Animation'))
              .id,
          languageId: 'ja',
        ),
        animationSeries: await getTVSeries(
            genre: genreTvList
                .firstWhere((element) => element.name.contains('Animation'))
                .id),
        tvShowsSeries: await getTVSeries(
            genre: genreTvList
                .firstWhere((element) => element.name.contains('Talk'))
                .id),
        documentalSeries: await getTVSeries(
            genre: genreTvList
                .firstWhere((element) => element.name.contains('Documentary'))
                .id),
      ));
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  Future<List<MediaItemEntity>> getMovies({
    required int genre,
    String? languageId = '',
  }) async {
    List<MediaItemRemoteEntity> movieList =
        await _movieRemoteDataSourceContract.getMediaTypeList(
      mediaType: MediaListConstants.movieMediaType,
      genreId: genre,
      languageId: languageId ?? '',
    );

    return movieList.map((e) => e.toMediaEntity()).toList();
  }

  Future<List<MediaItemEntity>> getTVSeries({
    required int genre,
    String languageId = '',
  }) async {
    List<MediaItemRemoteEntity> serieList =
        await _movieRemoteDataSourceContract.getMediaTypeList(
      mediaType: MediaListConstants.serieMediaType,
      genreId: genre,
      languageId: languageId,
    );
    return serieList.map((e) => e.toMediaEntity()).toList();
  }

  Future<List<GenreEntity>> getGenreList(String mediaType) async {
    final genreList = await _movieRemoteDataSourceContract.getGenreList(
      mediaType: mediaType,
    );
    return genreList.map((e) => e.toGenreEntity()).toList();
  }
}
