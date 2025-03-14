import 'package:film_flu/core/entities/pagination.dart';
import 'package:film_flu/domain/models/genre_entity.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/domain/models/production_company_entity.dart';
import 'package:film_flu/domain/models/video_entity.dart';

class MediaDetailInstruments {
  static const String movieIdMocked = '533535';
  static const MediaItemEntity mediaDetailMocked = MediaItemEntity(
    firstAirDate: '',
    name: '',
    backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
    genres: [
      GenreEntity(id: 28, name: 'Acción'),
      GenreEntity(id: 35, name: 'Comedia'),
      GenreEntity(id: 878, name: 'Ciencia ficción'),
    ],
    id: 533535,
    originalLanguage: 'en',
    originalTitle: 'Deadpool & Wolverine',
    overview:
        'Un apático Wade Wilson se afana en la vida civil tras dejar atrás sus días como Deadpool, un mercenario moralmente flexible. Pero cuando su mundo natal se enfrenta a una amenaza existencial, Wade debe volver a vestirse a regañadientes con un Lobezno aún más reacio a ayudar.',
    popularity: 4467.772,
    posterPath: '/9TFSqghEHrlBMRR63yTx80Orxva.jpg',
    productionCompanies: [
      ProductionCompanyEntity(
        id: 420,
        name: 'Marvel Studios',
        originCountry: 'US',
        logoPath: '/hUzeosd33nzE5MCNsZxCGEKTXaQ.png',
      ),
    ],
    releaseDate: '2024-07-24',
    title: 'Deadpool y Lobezno',
    voteAverage: 7.764,
    voteCount: 2437,
    videos: Pagination(
      results: [
        VideoEntity(key: 'i-Lt0FDtOuc', type: 'Teaser', official: true),
        VideoEntity(key: 'IrVXNTOSLgE', type: 'Teaser', official: true),
      ],
    ),
  );
}
