import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/data/datasources/remote/api/filmflu_api.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/data/models/review_remote_entity.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/person_remote_data_source_contract.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';

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
    required MediaType mediaTypeSelected,
    required int genreId,
    String? languageId,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaData(
      mediaType: mediaTypeSelected.name,
      language: await _appLocalDataSourceContract.getLanguage(),
      genres: genreId,
      page: 1,
      languageId: languageId ?? '',
    );
    return mediaData.results;
  }

  @override
  Future<MediaItemRemoteEntity> getMediaDataDay({
    required MediaType mediaTypeSelected,
  }) async {
    Pagination<MediaItemRemoteEntity> mediaDataDay =
        mediaTypeSelected == MediaType.movie
            ? await _filmFluApi.fetchMovieDay()
            : await _filmFluApi.fetchSerieDay();
    return mediaDataDay.results[0];
  }

  @override
  Future<List<MediaItemRemoteEntity>> paginateMediaData({
    required MediaType mediaTypeSelected,
    required int genreId,
    required int page,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaData(
      mediaType: mediaTypeSelected.name,
      language: await _appLocalDataSourceContract.getLanguage(),
      genres: genreId,
      page: page,
    );
    return mediaData.results;
  }

  @override
  Future<List<MediaItemRemoteEntity>> searchMediaData({
    required MediaType mediaTypeSelected,
    required String query,
  }) async {
    final mediaData = await _filmFluApi.searchMovie(
      mediaType: mediaTypeSelected.name,
      query: query,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return mediaData.results;
  }

  @override
  Future<MediaItemRemoteEntity> getMediaDetail({
    required MediaType mediaTypeSelected,
    required String mediaTypeId,
  }) async {
    final mediaData = await _filmFluApi.fetchMediaItem(
      mediaType: mediaTypeSelected.name,
      mediaTypeId: mediaTypeId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return mediaData;
  }

  @override
  Future<CreditsMediaRemoteEntity> getCredits({
    required MediaType mediaTypeSelected,
    required int mediaTypeId,
  }) async {
    final mediaData = await _filmFluApi.fetchCredits(
      mediaType: mediaTypeSelected.name,
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
    required MediaType mediaTypeSelected,
    required int mediaTypeId,
  }) async {
    final reviewData = await _filmFluApi.fetchReviews(
      mediaType: mediaTypeSelected.name,
      mediaTypeId: mediaTypeId,
      language: await _appLocalDataSourceContract.getLanguage(),
    );
    return reviewData;
  }
}
