import 'package:FilmFlu/app/types/result.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';

abstract class MediaListRepositoryContract {
  Future<Result<List<MediaItemEntity>>> getMediaList(
    String mediaType,
  );
}
