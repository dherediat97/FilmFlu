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
  Future<Pagination<MediaItemRemoteEntity>> fetchPopularMediaTypes(
    @Path('trendingType') String trendingType,
    @Path('mediaType') String mediaType,
  );

  @GET('/fetchMovie')
  Future<MediaItemRemoteEntity> fetchMovie(
    String mediaTypeId,
    String mediaType,
  );

  @GET('/fetchTrailer')
  Future<VideoRemoteEntity> fetchTrailer(
    String movieId,
    String? language,
    String mediaType,
  );

  @GET('/fetchCredits')
  Future<CreditsPersonRemoteEntity> fetchCredits(
    String movieId,
    String mediaType,
  );

  @GET('/searchMovie')
  Future<List<MediaItemRemoteEntity>> searchMovie(String movieSearched);

  @GET('/fetchPerson')
  Future<PersonEntity> fetchPerson(String personId);

  @GET('/fetchPersonCredits')
  Future<CreditsPersonRemoteEntity> fetchPersonCredits(String personId);
}
