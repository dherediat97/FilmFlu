import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/genre_result_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/media_response_remote_entity.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/domain/models/language_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'filmflu_api.g.dart';

@RestApi()
abstract class FilmFluApi {
  factory FilmFluApi(Dio dio, {String? baseUrl}) = _FilmFluApi;

  @GET('/discover/{mediaType}')
  Future<Pagination<MediaItemRemoteEntity>> fetchMediaData({
    @Path('mediaType') required String mediaType,
    @Query('language') String language = 'es-ES',
    @Query('sort_by') String sortBy = 'popularity.desc',
    @Query('region') String region = 'es-ES',
    @Query('with_genres') required int genres,
    @Query('with_original_language') String? languageId,
    @Query('page') int? page = 1,
  });

  @GET('/genre/{mediaType}/list')
  Future<GenreResultRemoteEntity> fetchGenreList({
    @Path('mediaType') required String mediaType,
  });

  @GET('/{mediaType}/{mediaTypeId}')
  Future<MediaItemRemoteEntity> fetchMediaItem({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
    @Query('append_to_response') String moreResponse = 'videos',
  });

  @GET('/movie/now_playing')
  Future<Pagination<MediaItemRemoteEntity>> fetchMovieDay();

  @GET('/tv/on_the_air')
  Future<Pagination<MediaItemRemoteEntity>> fetchSerieDay();

  @GET('/{mediaType}/{mediaTypeId}/credits')
  Future<CreditsMediaRemoteEntity> fetchCredits({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
  });

  @GET('/{mediaType}/{mediaTypeId}/reviews')
  Future<Pagination<ReviewRemoteEntity>> fetchReviews({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
  });

  @GET('/{mediaType}/{mediaTypeId}/images')
  Future<MediaResponseRemoteEntity> fetchMedia({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
  });

  @GET('/search/{mediaType}')
  Future<Pagination<MediaItemRemoteEntity>> searchMovie({
    @Path('mediaType') required String mediaType,
    @Query('language') String language = 'es-ES',
    @Query('query') required String query,
  });

  @GET('/person/{personId}')
  Future<PersonRemoteEntity> fetchPerson({
    @Path('personId') required String personId,
    @Query('language') String language = 'es-ES',
    @Query('append_to_response') String moreResponse = 'credits',
  });

  @GET('/configuration/languages')
  Future<LanguageEntity> fetchLanguages();
}
