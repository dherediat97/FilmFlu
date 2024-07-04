import 'package:FilmFlu/data/datasources/remote/api/filmflu_api.dart';
import 'package:FilmFlu/data/models/credits_media_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';
import 'package:FilmFlu/data/models/person_remote_entity.dart';
import 'package:FilmFlu/data/repositories/remote/media_list_remote_data_source_contract.dart';
import 'package:FilmFlu/data/repositories/remote/media_remote_data_source_contract.dart';
import 'package:FilmFlu/data/repositories/remote/person_remote_data_source_contract.dart';

class FilmFluRemoteDataSource
    implements
        MediaListRemoteDataSourceContract,
        MediaRemoteDataSourceContract,
        PersonRemoteDataSourceContract {
  final FilmFluApi _filmFluApi;

  FilmFluRemoteDataSource(this._filmFluApi);

  @override
  Future<List<MediaItemRemoteEntity>> getMediaTypeList(String mediaType) async {
    final mediaData = await _filmFluApi.fetchPopularMediaTypes(
      mediaType: mediaType,
      language: 'es-ES',
    );
    return mediaData.results;
  }

  @override
  Future<MediaItemRemoteEntity> getMediaDetail(
    String mediaType,
    String mediaTypeId,
  ) async {
    final mediaData = await _filmFluApi.fetchMediaItem(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: 'es-ES',
    );
    return mediaData;
  }

  @override
  Future<CreditsMediaRemoteEntity> getCredits(
    String mediaType,
    String mediaTypeId,
  ) async {
    final mediaData = await _filmFluApi.fetchCredits(
      mediaType: mediaType,
      mediaTypeId: mediaTypeId,
      language: 'es-ES',
    );
    return mediaData;
  }

  @override
  Future<PersonRemoteEntity> fetchPersonData(
    String personId,
  ) async {
    final personData = await _filmFluApi.fetchPerson(
      personId: personId,
    );
    return personData;
  }
}
