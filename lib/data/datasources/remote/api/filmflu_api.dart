import 'package:FilmFlu/core/entities/pagination.dart';
import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/models/person_remote_entity.dart';
import 'package:FilmFlu/data/models/video_remote_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'filmflu_api.g.dart';

@RestApi()
abstract class FilmFluApi {
  factory FilmFluApi(Dio dio, {String? baseUrl}) = _FilmFluApi;

  @GET('/trending/{mediaType}/{trendingType}')
  Future<Pagination<MediaItemRemoteEntity>> fetchPopularMediaTypes({
    @Path('trendingType') required String trendingType,
    @Path('mediaType') required String mediaType,
    @Query('language') String language = 'es-ES',
  });

  @GET('/{mediaType}/{mediaTypeId}')
  Future<MediaItemRemoteEntity> fetchMovie({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
  });

  @GET('/fetchTrailer')
  Future<VideoRemoteEntity> fetchTrailer(
    String movieId,
    String? language,
    String mediaType,
  );

  @GET('/{mediaType}/{mediaTypeId}/credits')
  Future<CreditsPersonRemoteEntity> fetchCredits({
    @Path('mediaType') required String mediaType,
    @Path('mediaTypeId') required String mediaTypeId,
    @Query('language') String language = 'es-ES',
  });

  @GET('/searchMovie')
  Future<List<MediaItemRemoteEntity>> searchMovie(String movieSearched);

  @GET('/fetchPerson')
  Future<PersonEntity> fetchPerson(String personId);

  @GET('/fetchPersonCredits')
  Future<CreditsPersonRemoteEntity> fetchPersonCredits(String personId);
}
