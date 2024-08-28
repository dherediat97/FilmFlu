import 'package:film_flu/domain/models/media_simple_item_entity.dart';

class MediaListInstruments {
  static const MediaSimpleItemEntity movieMocked = MediaSimpleItemEntity(
    id: 533535,
    posterPath: '/9TFSqghEHrlBMRR63yTx80Orxva.jpg',
  );

  static const Map<int, List<MediaSimpleItemEntity>> movieList = {
    28: [movieMocked],
  };
  static const Map<int, List<MediaSimpleItemEntity>> serieList = {
    28: [movieMocked]
  };
}
