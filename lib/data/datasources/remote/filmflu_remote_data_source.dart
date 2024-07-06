import 'package:film_flu/data/datasources/remote/api/filmflu_api.dart';
import 'package:film_flu/data/models/credits_media_remote_entity.dart';
import 'package:film_flu/data/models/media_item_remote_entity.dart';
import 'package:film_flu/data/models/person_remote_entity.dart';
import 'package:film_flu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:film_flu/data/repositories/remote/person_remote_data_source_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilmFluRemoteDataSource
    implements
        MediaListRemoteDataSourceContract,
        MediaRemoteDataSourceContract,
        PersonRemoteDataSourceContract {
  final FilmFluApi _filmFluApi;

  FilmFluRemoteDataSource(this._filmFluApi);

  @override
  Future<List<MediaItemRemoteEntity>> getMediaTypeList({
    required String mediaType,
    required int genreId,
    String? languageId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('LANGUAGE') ?? 'es-ES';
    final mediaData = await _filmFluApi.fetchPopularMediaTypes(
      mediaType: mediaType,
      language: languageCode,
      genres: genreId,
      languageId: languageId ?? '',
    );
    return mediaData.results;
  }

  @override
  Future<MediaItemRemoteEntity> getMediaDetail(
    String mediaType,
    int mediaTypeId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('LANGUAGE') ?? 'es-ES';
    final mediaData = await _filmFluApi.fetchMediaItem(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: languageCode,
    );
    return mediaData;
  }

  @override
  Future<CreditsMediaRemoteEntity> getCredits(
    String mediaType,
    int mediaTypeId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('LANGUAGE') ?? 'es-ES';
    final mediaData = await _filmFluApi.fetchCredits(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: languageCode,
    );
    return mediaData;
  }

  @override
  Future<PersonRemoteEntity> fetchPersonData(
    int personId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('LANGUAGE') ?? 'es-ES';
    final personData = await _filmFluApi.fetchPerson(
      personId: personId,
      language: languageCode,
    );
    return personData;
  }
}
