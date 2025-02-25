import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/data_media_list.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:film_flu/presentation/notifiers/media_filter_notifier.dart';

class MediaRepositoryImpl implements MediaRepository {
  @override
  Future<MediaItemEntity> getMediaItem(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  ) async {
    final response =
        await DioClient.instance.get('/${mediaTypeSelected.name}/$mediaTypeId');

    final mediaItem = MediaItemEntity.fromJson(response);

    return mediaItem;
  }

  @override
  Future<CreditsMediaEntity> getCredits(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  ) async {
    try {
      final response = await DioClient.instance
          .get('/${mediaTypeSelected.name}/$mediaTypeId/credits');

      final credits = CreditsMediaEntity.fromJson(response);

      return credits;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<List<ReviewEntity>?> getReviews(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  ) async {
    try {
      final reviewData = await DioClient.instance
          .get('/${mediaTypeSelected.name}/$mediaTypeId/reviews');

      List<ReviewRemoteEntity> reviewList = reviewData['results']
          .map<ReviewRemoteEntity>(
              (e) => ReviewRemoteEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      return reviewList.map((e) => e.toReviewEntity()).toList();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<MediaResponseEntity> getMedia(
    MediaType mediaTypeSelected,
    String mediaTypeId,
  ) async {
    try {
      final response = await DioClient.instance
          .get('/${mediaTypeSelected.name}/$mediaTypeId');
      final mediaData = MediaResponseEntity.fromJson(response);

      return mediaData;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    int genreId,
    String languageId,
  ) async {
    try {
      return mediaTypeSelected == MediaType.movie
          ? getMovies(genreId, languageId)
          : getTVSeries(genreId, languageId);
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    int genreId,
    String? languageId,
  ) async {
    try {
      final response = await DioClient.instance
          .get('/discover/${MediaType.movie.name}', queryParameters: {
        'with_genres': genreId,
        'language': languageId,
      });

      if (response.isEmpty) {
        return (0, <MediaSimpleItemEntity>[]);
      }
      final movieResponse = DataMediaList.fromJson(response);

      return (movieResponse.page, movieResponse.results.toList());
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getTVSeries(
    int genreId,
    String languageId,
  ) async {
    try {
      final response = await DioClient.instance
          .get('/discover/${MediaType.tv.name}', queryParameters: {
        'with_genres': genreId,
        'language': languageId,
      });

      if (response.isEmpty) {
        return (0, <MediaSimpleItemEntity>[]);
      }
      final movieResponse = DataMediaList.fromJson(response);

      return (movieResponse.page, movieResponse.results.toList());
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<List<MediaItemEntity>> searchMediaData(
    String languageName,
    String query,
  ) async {
    try {
      final response =
          await DioClient.instance.get('/search/multi', queryParameters: {
        'query': query,
        'language': languageName,
      });

      List<MediaItemRemoteEntity> mediaData = response['results']
          .map<MediaItemRemoteEntity>(
              (e) => MediaItemRemoteEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      return mediaData.map((e) => e.toMediaEntity()).toList();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<MediaItemEntity> getMediaDataDay(MediaFilter mediaFilter) async {
    final response = mediaFilter.mediaTypeSelected == MediaType.movie
        ? await DioClient.instance.get(
            '/${mediaFilter.mediaTypeSelected.name}/now_playing',
            queryParameters: {
              'language': mediaFilter.languageId,
            },
          )
        : await DioClient.instance.get(
            '/${mediaFilter.mediaTypeSelected.name}/on_the_air',
            queryParameters: {
              'language': mediaFilter.languageId,
            },
          );

    List<MediaItemRemoteEntity> mediaData = response['results']
        .map<MediaItemRemoteEntity>(
            (e) => MediaItemRemoteEntity.fromJson(e as Map<String, dynamic>))
        .toList();

    return mediaData.map((e) => e.toMediaEntity()).first;
  }
}
