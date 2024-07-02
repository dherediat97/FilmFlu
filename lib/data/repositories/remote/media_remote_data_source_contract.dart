import 'package:FilmFlu/data/models/credits_person_remote_entity.dart';
import 'package:FilmFlu/data/models/media_item_remote_entity.dart';

abstract class MediaRemoteDataSourceContract {
  Future<MediaItemRemoteEntity> getMediaDetail(
    String mediaType,
    String mediaTypeId,
  );
  Future<CreditsPersonRemoteEntity> getCredits(
    String mediaType,
    String mediaTypeId,
  );
}
