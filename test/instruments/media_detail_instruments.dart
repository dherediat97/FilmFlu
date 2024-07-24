import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';

class MediaDetailInstruments {
  static const MediaItemEntity mediaDetailMocked = MediaItemEntity(
    id: 1,
    backdropPath: '',
    credits: CreditsMediaEntity(cast: [], crew: []),
    genres: [],
    mediaType: 'movie',
    name: '',
    firstAirDate: '',
    originalLanguage: '',
    originalTitle: '',
    overview: '',
    popularity: 0,
    posterPath: '',
    releaseDate: '',
  );
}
