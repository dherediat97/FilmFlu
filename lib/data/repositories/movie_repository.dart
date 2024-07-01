import 'package:FilmFlu/app/types/errors/network_error.dart';
import 'package:FilmFlu/app/types/repository_error.dart';
import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/movie_remote_data_source_contract.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/domain/repository_contracts/movie_repository_contract.dart';

class MovieRepository implements MovieRepositoryContract {
  final MovieRemoteDataSourceContract _movieRemoteDataSourceContract;

  MovieRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<List<MediaItemEntity>>> getMovies() async {
    try {
      final movieData = await _movieRemoteDataSourceContract.getMovies();
      return Result.success(movieData.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaItemEntity>>> getTVSeries() async {
    try {
      final movieData = await _movieRemoteDataSourceContract.getTVSeries();
      return Result.success(movieData.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
