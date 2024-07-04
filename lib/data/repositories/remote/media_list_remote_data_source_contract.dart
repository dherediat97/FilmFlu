import 'package:film_flu/data/models/media_item_remote_entity.dart';

abstract class MediaListRemoteDataSourceContract {
  Future<List<MediaItemRemoteEntity>> getMediaTypeList(String mediaType);
}
