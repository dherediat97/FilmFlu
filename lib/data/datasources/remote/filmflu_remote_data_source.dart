import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/datasources/remote/api/filmflu_api.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/genre_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/person_remote_data_source_contract.dart';

class FilmFluRemoteDataSource
    implements
        MediaListRemoteDataSourceContract,
        MediaRemoteDataSourceContract,
        PersonRemoteDataSourceContract {
  final FilmFluApi _filmFluApi;

  final AppLocalDataSourceContract _appLocalDataSourceContract;

  FilmFluRemoteDataSource(this._filmFluApi, this._appLocalDataSourceContract);

  @override
  Future<List<MediaItemRemoteEntity>> getMediaTypeList({
    required String mediaType,
    required int genreId,
    String? languageId,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaData(
      mediaType: mediaType,
      language: await _appLocalDataSourceContract.getLanguage(),
      genres: genreId,
      page: 1,
      languageId: languageId ?? '',
    );
    return mediaData.results;
  }

  @override
  Future<List<MediaItemRemoteEntity>> paginateMediaData({
    required String mediaType,
    required int genreId,
    required int page,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaData(
      mediaType: mediaType,
      language: await _appLocalDataSourceContract.getLanguage(),
      genres: genreId,
      page: page,
    );
    return mediaData.results;
  }

  @override
  Future<List<GenreRemoteEntity>> getGenreList({
    required String mediaType,
  }) async {
    final mediaData = await _filmFluApi.fetchGenreList(
      mediaType: mediaType,
    );
    return mediaData.genres;
  }

  @override
  Future<MediaItemRemoteEntity> getMediaDetail({
    required String mediaType,
    required int mediaTypeId,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaItem(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return mediaData;
  }

  @override
  Future<CreditsMediaRemoteEntity> getCredits({
    required String mediaType,
    required int mediaTypeId,
  }) async {
    final mediaData = await _filmFluApi.fetchCredits(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return mediaData;
  }

  @override
  Future<PersonRemoteEntity> fetchPersonData(
    int personId,
  ) async {
    final personData = await _filmFluApi.fetchPerson(
      personId: personId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return personData;
  }

  @override
  Future<Pagination<ReviewRemoteEntity>>? getReviews({
    required String mediaType,
    required int mediaTypeId,
  }) async {
    final reviewData = await _filmFluApi.fetchReviews(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return reviewData;
  }
}
