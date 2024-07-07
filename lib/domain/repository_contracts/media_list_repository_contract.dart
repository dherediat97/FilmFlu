import 'package:film_flu/app/types/result.dart';
import 'package:film_flu/domain/models/media_data_entity.dart';

abstract class MediaListRepositoryContract {
  Future<Result<MediaDataEntity>> getMediaData();
}
