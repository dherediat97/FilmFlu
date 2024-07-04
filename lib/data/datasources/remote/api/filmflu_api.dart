import 'package:FilmFlu/core/entities/pagination.dart';
import 'package:FilmFlu/data/models/credits_media_remote_entity.dart';
import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/models/person_remote_entity.dart';
import 'package:FilmFlu/data/models/video_remote_entity.dart';
import 'package:FilmFlu/domain/models/language_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'filmflu_api.g.dart';

@RestApi()
abstract class FilmFluApi {
  factory FilmFluApi(Dio dio, {String? baseUrl}) = _FilmFluApi;

  @GET('/discover/{mediaType}')
  Future<Pagination<MediaItemRemoteEntity>> fetchPopularMediaTypes({
    @Path('mediaType') required String mediaType,
    @Query('language') String language = 'es-ES',
    @Query('sort_by') String sortBy = 'popularity.desc',
    @Query('region') String year = 'es',
    @Query('with_genres') String genres = '',
  });

  @GET('/{mediaType}/{mediaTypeId}')
  Future<MediaItemRemoteEntity> fetchMediaItem({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
    @Query('append_to_response') String moreResponse = 'videos',
  });

  @GET('/fetchTrailer')
  Future<VideoRemoteEntity> fetchTrailer(
    String movieId,
    String? language,
    String mediaType,
  );

  @GET('/{mediaType}/{mediaTypeId}/credits')
  Future<CreditsMediaRemoteEntity> fetchCredits({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
  });

  @GET('/searchMovie')
  Future<List<MediaItemRemoteEntity>> searchMovie(String movieSearched);

  @GET('/person/{personId}')
  Future<PersonRemoteEntity> fetchPerson({
    @Path('personId') required String personId,
    @Query('language') String language = 'es-ES',
    @Query('append_to_response') String moreResponse = 'credits',
  });

  @GET('/fetchPersonCredits')
  Future<CreditsPersonRemoteEntity> fetchPersonCredits(String personId);

  @GET('/configuration/languages')
  Future<LanguageEntity> fetchLanguages();
}
