import 'package:dio/dio.dart';
import 'package:film_flu/data/datasources/remote/api/network/dio_client.dart';
import 'package:film_flu/data/datasources/remote/api/network/http_exception.dart';
import 'package:film_flu/data/enums/genres_id.dart';
import 'package:film_flu/data/enums/order_options.dart';
import 'package:film_flu/data/enums/sort_options.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/data_media_list.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/media_response_entity.dart';
import 'package:film_flu/domain/models/media_simple_item_entity.dart';
import 'package:film_flu/domain/models/review_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  @override
  Future<MediaItemEntity> getMediaItem(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageCode,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/$mediaTypeSelected/$mediaTypeId',
        queryParameters: {
          'append_to_response': 'videos',
          'language': languageCode,
        },
      );

      MediaItemRemoteEntity mediaData = MediaItemRemoteEntity.fromJson(
        response,
      );
      return mediaData.toMediaEntity();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<CreditsMediaEntity> getCredits(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/$mediaTypeSelected/$mediaTypeId/credits',
        queryParameters: {'language': languageName},
      );

      CreditsMediaRemoteEntity creditsMediaEntity =
          CreditsMediaRemoteEntity.fromJson(response);

      return creditsMediaEntity.toCreditsEntity();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<List<ReviewEntity>> getReviews(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    try {
      final reviewData = await DioClient.instance.get(
        '/$mediaTypeSelected/$mediaTypeId/reviews',
        queryParameters: {'language': languageName},
      );

      List<ReviewRemoteEntity> reviewList =
          reviewData['results']
              .map<ReviewRemoteEntity>(
                (e) => ReviewRemoteEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList();

      return reviewList.map((e) => e.toReviewEntity()).toList();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<MediaResponseEntity> getMedia(
    String mediaTypeSelected,
    String mediaTypeId,
    String languageName,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/$mediaTypeSelected/$mediaTypeId',
      );
      final mediaData = MediaResponseEntity.fromJson(response);

      return mediaData;
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMediaDataByGenre(
    MediaType mediaTypeSelected,
    GenresId genreId,
    String languageId,
    int page,
    SortOptions? sortBy,
    OrderOptions? orderBy,
  ) async {
    try {
      return mediaTypeSelected == MediaType.movie
          ? getMovies(
            genreId,
            languageId,
            page,
            sortBy != null && orderBy != null
                ? '${sortBy.name}.${orderBy.name}'
                : '${SortOptions.movieDate}.${OrderOptions.desc}',
          )
          : getTVSeries(
            genreId,
            languageId,
            page,
            sortBy != null && orderBy != null
                ? '${sortBy.name}.${orderBy.name}'
                : '${SortOptions.tvSeriesDate}.${OrderOptions.desc}',
          );
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<(int page, List<MediaSimpleItemEntity> items)> getMovies(
    GenresId genreId,
    String? languageCode,
    int page,
    String sortBy,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/discover/${MediaType.movie.name}',
        queryParameters: {
          'with_genres': genreId.id,
          'sort_by': sortBy,
          'language': languageCode,
          'primary_release_year': DateTime.now().year,
          'page': page,
        },
      );

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
    GenresId genreId,
    String languageCode,
    int page,
    String sortBy,
  ) async {
    try {
      final response = await DioClient.instance.get(
        '/discover/${MediaType.tv.name}',
        queryParameters: {
          'with_genres': genreId.id,
          'sort_by': sortBy,
          'language': languageCode,
          'first_air_date_year': DateTime.now().year,
          'page': page,
        },
      );

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
      final response = await DioClient.instance.get(
        '/search/multi',
        queryParameters: {'query': query, 'language': languageName},
      );

      List<MediaItemRemoteEntity> mediaData =
          response['results']
              .map<MediaItemRemoteEntity>(
                (e) =>
                    MediaItemRemoteEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList();

      return mediaData.map((e) => e.toMediaEntity()).toList();
    } on DioException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<MediaItemEntity> getMediaDataDay(
    MediaType mediaTypeSelected,
    String languageCode,
  ) async {
    final response =
        mediaTypeSelected == MediaType.movie
            ? await DioClient.instance.get(
              '/${mediaTypeSelected.name}/now_playing',
              queryParameters: {'language': languageCode},
            )
            : await DioClient.instance.get(
              '/${mediaTypeSelected.name}/on_the_air',
              queryParameters: {'language': languageCode},
            );

    List<MediaItemRemoteEntity> mediaData =
        response['results']
            .map<MediaItemRemoteEntity>(
              (e) => MediaItemRemoteEntity.fromJson(e as Map<String, dynamic>),
            )
            .toList();

    return mediaData.map((e) => e.toMediaEntity()).first;
  }
}
