import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';

class MediaListRepository implements MediaListRepositoryContract {
  final MediaListRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaListRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<List<MediaItemEntity>>> getMediaDataByGenre(
    String mediaType,
    int genreId,
    String languageId,
  ) async {
    try {
      return mediaType == MediaListConstants.movieMediaType
          ? getMovies(genreId: genreId, languageId: languageId)
          : getTVSeries(genreId: genreId, languageId: languageId);
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaItemEntity>>> paginateMediaData({
    required String mediaType,
    required int genreId,
    required int page,
  }) async {
    try {
      List<MediaItemRemoteEntity> movieList =
          await _movieRemoteDataSourceContract.paginateMediaData(
        mediaType: mediaType,
        genreId: genreId,
        page: page,
      );

      return Result.success(movieList.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaItemEntity>>> getMovies({
    required int genreId,
    String? languageId = '',
  }) async {
    try {
      List<MediaItemRemoteEntity> movieList =
          await _movieRemoteDataSourceContract.getMediaTypeList(
        mediaType: MediaListConstants.movieMediaType,
        genreId: genreId,
        languageId: languageId ?? '',
      );

      return Result.success(movieList.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaItemEntity>>> getTVSeries({
    required int genreId,
    String languageId = '',
  }) async {
    try {
      List<MediaItemRemoteEntity> serieList =
          await _movieRemoteDataSourceContract.getMediaTypeList(
        mediaType: MediaListConstants.serieMediaType,
        genreId: genreId,
        languageId: languageId,
      );
      return Result.success(serieList.map((e) => e.toMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<MediaItemEntity>> getMediaDataDay({
    required String mediaType,
  }) async {
    try {
      MediaItemRemoteEntity mediaData = await _movieRemoteDataSourceContract
          .getMediaDataDay(mediaType: mediaType);
      return Result.success(mediaData.toMediaEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
