import 'package:film_flu/data/enums/media_type.dart';

enum GenresId {
  //MOVIES GENRES
  actionMovies(id: 28, name: 'Action', mediaType: MediaType.movie),
  adventure(id: 12, name: 'Adventure', mediaType: MediaType.movie),
  animationMovies(id: 16, name: 'Animation', mediaType: MediaType.movie),
  comedyMovies(id: 35, name: 'Comedy', mediaType: MediaType.movie),
  crimeMovies(id: 80, name: 'Crime', mediaType: MediaType.movie),
  documentaryMovies(id: 99, name: 'Documentary', mediaType: MediaType.movie),
  dramaMovies(id: 18, name: 'Drama', mediaType: MediaType.movie),
  familyMovies(id: 10751, name: 'Family', mediaType: MediaType.movie),
  fantasyMovies(id: 14, name: 'Fantasy', mediaType: MediaType.movie),
  historyMovies(id: 36, name: 'History', mediaType: MediaType.movie),
  horrorMovies(id: 27, name: 'Horror', mediaType: MediaType.movie),
  musicMovies(id: 10402, name: 'Music', mediaType: MediaType.movie),
  mysteryMovies(id: 9648, name: 'Mystery', mediaType: MediaType.movie),
  romanceMovies(id: 10749, name: 'Romance', mediaType: MediaType.movie),
  scifiMovies(id: 878, name: 'Science Fiction', mediaType: MediaType.movie),
  tvMovies(id: 10770, name: 'TV Movie', mediaType: MediaType.movie),
  thrillerMovies(id: 53, name: 'Thriller', mediaType: MediaType.movie),
  warMovies(id: 10752, name: 'War', mediaType: MediaType.movie),
  westernMovies(id: 37, name: 'Western', mediaType: MediaType.movie),
  //TV SERIES
  actionAdventureSeries(
      id: 10759, name: 'Action & Adventure', mediaType: MediaType.tv),
  animationSeries(id: 16, name: 'Adventure', mediaType: MediaType.tv),
  comedySeries(id: 35, name: 'Comedy', mediaType: MediaType.tv),
  crimeSeries(id: 80, name: 'Crime', mediaType: MediaType.tv),
  documentarySeries(id: 99, name: 'Documentary', mediaType: MediaType.tv),
  dramaSeries(id: 18, name: 'Drama', mediaType: MediaType.tv),
  familySeries(id: 10751, name: 'Family', mediaType: MediaType.tv),
  kidsSeries(id: 10762, name: 'Kids', mediaType: MediaType.tv),
  mysterySeries(id: 9648, name: 'Mystery', mediaType: MediaType.tv),
  newsSeries(id: 10763, name: 'News', mediaType: MediaType.tv),
  realitySeries(id: 10764, name: 'Reality', mediaType: MediaType.tv),
  sciFiFantasySeries(
      id: 10765, name: 'Sci-Fi & Fantasy', mediaType: MediaType.tv),
  soapSeries(id: 10766, name: 'Soap', mediaType: MediaType.tv),
  talkSeries(id: 10767, name: 'Talk', mediaType: MediaType.tv),
  warSeries(id: 10768, name: 'War & Politics', mediaType: MediaType.tv),
  westernSeries(id: 37, name: 'Western', mediaType: MediaType.tv);

  const GenresId({
    required this.name,
    required this.id,
    required this.mediaType,
  });

  final String name;
  final int id;
  final MediaType mediaType;
}
