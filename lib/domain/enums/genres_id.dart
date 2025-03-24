import 'package:film_flu/domain/enums/media_type.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum GenresId {
  //MOVIES GENRES
  actionMovies(
    id: 28,
    name: 'Action',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  adventure(
    id: 12,
    name: 'Adventure',
    mediaType: MediaType.movie,
    icon: Symbols.explore,
  ),
  animationMovies(
    id: 16,
    name: 'Animation',
    mediaType: MediaType.movie,
    icon: Symbols.animation,
  ),
  comedyMovies(
    id: 35,
    name: 'Comedy',
    mediaType: MediaType.movie,
    icon: Symbols.mood,
  ),
  crimeMovies(
    id: 80,
    name: 'Crime',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  documentaryMovies(
    id: 99,
    name: 'Documentary',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  dramaMovies(
    id: 18,
    name: 'Drama',
    mediaType: MediaType.movie,
    icon: Symbols.theater_comedy,
  ),
  familyMovies(
    id: 10751,
    name: 'Family',
    mediaType: MediaType.movie,
    icon: Symbols.family_restroom,
  ),
  fantasyMovies(
    id: 14,
    name: 'Fantasy',
    mediaType: MediaType.movie,
    icon: Symbols.castle,
  ),
  historyMovies(
    id: 36,
    name: 'History',
    mediaType: MediaType.movie,
    icon: Symbols.account_balance_rounded,
  ),
  horrorMovies(
    id: 27,
    name: 'Horror',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  musicMovies(
    id: 10402,
    name: 'Music',
    mediaType: MediaType.movie,
    icon: Symbols.piano_rounded,
  ),
  mysteryMovies(
    id: 9648,
    name: 'Mystery',
    mediaType: MediaType.movie,
    icon: Symbols.toys_and_games,
  ),
  romanceMovies(
    id: 10749,
    name: 'Romance',
    mediaType: MediaType.movie,
    icon: Symbols.favorite_rounded,
  ),
  scifiMovies(
    id: 878,
    name: 'Science Fiction',
    mediaType: MediaType.movie,
    icon: Symbols.science,
  ),
  tvMovies(
    id: 10770,
    name: 'TV Movie',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  thrillerMovies(
    id: 53,
    name: 'Thriller',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  warMovies(
    id: 10752,
    name: 'War',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  westernMovies(
    id: 37,
    name: 'Western',
    mediaType: MediaType.movie,
    icon: Symbols.question_mark,
  ),
  //TV SERIES
  actionAdventureSeries(
    id: 10759,
    name: 'Action & Adventure',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  animationSeries(
    id: 16,
    name: 'Adventure',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  comedySeries(
    id: 35,
    name: 'Comedy',
    mediaType: MediaType.tv,
    icon: Symbols.mood,
  ),
  crimeSeries(
    id: 80,
    name: 'Crime',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  documentarySeries(
    id: 99,
    name: 'Documentary',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  dramaSeries(
    id: 18,
    name: 'Drama',
    mediaType: MediaType.tv,
    icon: Symbols.theater_comedy,
  ),
  familySeries(
    id: 10751,
    name: 'Family',
    mediaType: MediaType.tv,
    icon: Symbols.family_restroom,
  ),
  kidsSeries(
    id: 10762,
    name: 'Kids',
    mediaType: MediaType.tv,
    icon: Symbols.toys,
  ),
  mysterySeries(
    id: 9648,
    name: 'Mystery',
    mediaType: MediaType.tv,
    icon: Symbols.toys_and_games,
  ),
  newsSeries(
    id: 10763,
    name: 'News',
    mediaType: MediaType.tv,
    icon: Symbols.newspaper,
  ),
  realitySeries(
    id: 10764,
    name: 'Reality',
    mediaType: MediaType.tv,
    icon: Symbols.live_tv,
  ),
  sciFiFantasySeries(
    id: 10765,
    name: 'Sci-Fi & Fantasy',
    mediaType: MediaType.tv,
    icon: Symbols.castle,
  ),
  soapSeries(
    id: 10766,
    name: 'Soap',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  talkSeries(
    id: 10767,
    name: 'Talk',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  warSeries(
    id: 10768,
    name: 'War & Politics',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  ),
  westernSeries(
    id: 37,
    name: 'Western',
    mediaType: MediaType.tv,
    icon: Symbols.question_mark,
  );

  const GenresId({
    required this.name,
    required this.id,
    required this.mediaType,
    required this.icon,
  });

  final String name;
  final int id;
  final MediaType mediaType;
  final IconData? icon;
}
