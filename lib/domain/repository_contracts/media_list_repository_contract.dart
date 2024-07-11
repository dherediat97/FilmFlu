import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_data_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';

abstract class MediaListRepositoryContract {
  Future<Result<MediaDataEntity>> getMediaData();

  Future<Result<List<MediaItemEntity>>> paginateMediaData({
    required String mediaType,
    required int page,
    required int genreId,
  });
}
