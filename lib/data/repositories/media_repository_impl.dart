import 'package:film_flu/app/types/errors/network_error.dart';
import 'package:film_flu/app/types/repository_error.dart';
import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/data/datasources/remote/api/filmflu_api.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/media_response_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';

class MediaRepositoryImpl implements MediaRepository {
  final FilmFluApi filmFluApi;

  const MediaRepositoryImpl(this.filmFluApi);

  @override
  Future<MediaItemEntity> getMediaItem({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    final mediaItemData = await filmFluApi.fetchMediaItem(
      mediaType: mediaTypeSelected.name,
      mediaTypeId: mediaTypeId,
    );
    return mediaItemData.toMediaEntity();
  }

  @override
  Future<Result<CreditsMediaEntity>> getCredits({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    try {
      final creditData = await filmFluApi.fetchCredits(
        mediaType: mediaTypeSelected.name,
        mediaTypeId: mediaTypeId,
      );
      return Result.success(creditData.toCreditsEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<List<ReviewEntity>?>> getReviews({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    try {
      final reviewData = await filmFluApi.fetchReviews(
        mediaType: mediaTypeSelected.name,
        mediaTypeId: mediaTypeId,
      );

      List<ReviewRemoteEntity> reviewList = reviewData.results;

      return Result.success(reviewList.map((e) => e.toReviewEntity()).toList());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<Result<MediaResponseEntity>> getMedia({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    try {
      final mediaData = await filmFluApi.fetchMedia(
        mediaType: mediaTypeSelected.name,
        mediaTypeId: mediaTypeId,
      );
      return Result.success(mediaData.toMediaRemote());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)>
      getMediaDataByGenre({
    required MediaType mediaTypeSelected,
    required int genreId,
    required String languageId,
  }) async {
    return mediaTypeSelected == MediaType.movie
        ? getMovies(genreId: genreId, languageId: languageId)
        : getTVSeries(genreId: genreId, languageId: languageId);
  }

  // @override
  // Future<Result<List<MediaSimpleItemEntity>>> paginateMediaData({
  //   required MediaType mediaTypeSelected,
  //   required int genreId,
  //   required int page,
  // }) async {
  //   try {
  //     List<MediaItemRemoteEntity> movieList =
  //         await filmFluApi.(
  //       mediaTypeSelected: mediaTypeSelected,
  //       genreId: genreId,
  //       page: page,
  //     );

  //     return Result.success(
  //         movieList.map((e) => e.toSimpleMediaEntity()).toList());
  //   } catch (error) {
  //     return Result.failure(
  //       error: RepositoryError.fromDataSourceError(
  //         NetworkError.fromException(error),
  //       ),
  //     );
  //   }
  // }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getMovies({
    required int genreId,
    String? languageId = '',
  }) async {
    List<MediaItemRemoteEntity> movieList = await filmFluApi.fetchMediaData(
      mediaType: MediaType.movie.name,
      genres: genreId,
      languageId: languageId,
    );

    return (
      movieList.length,
      movieList.map((e) => e.toSimpleMediaEntity()).toList()
    );
  }

  @override
  Future<(int totalItems, List<MediaSimpleItemEntity> items)> getTVSeries({
    required int genreId,
    String languageId = '',
  }) async {
    List<MediaItemRemoteEntity> serieList = await filmFluApi.fetchMediaData(
      mediaType: MediaType.tv.name,
      genres: genreId,
      languageId: languageId,
    );

    return (
      serieList.length,
      serieList.map((e) => e.toSimpleMediaEntity()).toList()
    );
  }

  @override
  Future<Result<List<MediaItemEntity>>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  }) async {
    try {
      List<MediaItemRemoteEntity> mediaData = await filmFluApi.searchMovie(
        mediaType: mediaTypeSelected.name,
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
      MediaItemRemoteEntity mediaData = await filmFluApi.fetchMovieDay();
      return Result.success(mediaData.toMediaDayEntity());
    } catch (error) {
      return Result.failure(
        error: RepositoryError.fromDataSourceError(
          NetworkError.fromException(error),
        ),
      );
    }
  }
}
