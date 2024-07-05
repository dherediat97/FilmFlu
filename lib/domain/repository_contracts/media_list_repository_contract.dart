import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';

abstract class MediaListRepositoryContract {
  Future<Result<List<MediaItemEntity>>> getMediaList({
    required String mediaType,
    required int genreId,
    String? languageId = '',
  });
}
