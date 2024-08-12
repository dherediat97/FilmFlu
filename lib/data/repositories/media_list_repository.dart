import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';

class MediaListRepository implements MediaListRepositoryContract {
  final MediaListRemoteDataSourceContract _movieRemoteDataSourceContract;

  MediaListRepository(
    this._movieRemoteDataSourceContract,
  );

  @override
  Future<Result<List<MediaSimpleItemEntity>>> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  ) async {
    try {
      return mediaTypeSelected == MediaType.movie
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
  Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
    required MediaType mediaTypeSelected,
    required int genreId,
    required int page,
  }) async {
    try {
      List<MediaItemRemoteEntity> movieList =
          await _movieRemoteDataSourceContract.paginateMediaData(
        mediaTypeSelected: mediaTypeSelected,
        genreId: genreId,
        page: page,
      );

      return Result.success(
          movieList.map((e) => e.toSimpleMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaSimpleItemEntity>>> getMovies({
    required int genreId,
    String? languageId = '',
  }) async {
    try {
      List<MediaItemRemoteEntity> movieList =
          await _movieRemoteDataSourceContract.getMediaTypeList(
        mediaTypeSelected: MediaType.movie,
        genreId: genreId,
        languageId: languageId ?? '',
      );

      return Result.success(
          movieList.map((e) => e.toSimpleMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaSimpleItemEntity>>> getTVSeries({
    required int genreId,
    String languageId = '',
  }) async {
    try {
      List<MediaItemRemoteEntity> serieList =
          await _movieRemoteDataSourceContract.getMediaTypeList(
        mediaTypeSelected: MediaType.tv,
        genreId: genreId,
        languageId: languageId,
      );
      return Result.success(
          serieList.map((e) => e.toSimpleMediaEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  }) async {
    try {
      List<MediaItemRemoteEntity> mediaData =
          await _movieRemoteDataSourceContract.searchMediaData(
        mediaTypeSelected: mediaTypeSelected,
        query: query,
      );
      return Result.success(mediaData.map((e) => e.toMediaEntity()).toList());
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
    required MediaType mediaTypeSelected,
  }) async {
    try {
      MediaItemRemoteEntity mediaData = await _movieRemoteDataSourceContract
          .getMediaDataDay(mediaTypeSelected: mediaTypeSelected);
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
