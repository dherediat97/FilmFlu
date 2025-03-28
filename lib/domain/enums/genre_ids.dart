import 'package:film_flu/domain/enums/media_types.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum GenreIds {
  //MOVIES GENRES
  actionMovies(
    id: 28,
    name: 'Action',
    mediaType: MediaType.movie,
    icon: Symbols.swords,
  ),
  adventure(
    id: 12,
    name: 'Adventure',
    mediaType: MediaType.movie,
    icon: Symbols.travel_explore,
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
    icon: Symbols.sentiment_very_satisfied,
  ),
  crimeMovies(
    id: 80,
    name: 'Crime',
    mediaType: MediaType.movie,
    icon: Symbols.gavel,
  ),
  documentaryMovies(
    id: 99,
    name: 'Documentary',
    mediaType: MediaType.movie,
    icon: Symbols.library_books,
  ),
  dramaMovies(
    id: 18,
    name: 'Drama',
    mediaType: MediaType.movie,
    icon: Symbols.theaters,
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
    icon: Symbols.history_edu,
  ),
  horrorMovies(
    id: 27,
    name: 'Horror',
    mediaType: MediaType.movie,
    icon: Symbols.masks,
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
    icon: Symbols.search,
  ),
  romanceMovies(
    id: 10749,
    name: 'Romance',
    mediaType: MediaType.movie,
    icon: Symbols.heart_broken,
  ),
  scifiMovies(
    id: 878,
    name: 'Science Fiction',
    mediaType: MediaType.movie,
    icon: Symbols.rocket_launch,
  ),
  tvMovies(
    id: 10770,
    name: 'TV Movie',
    mediaType: MediaType.movie,
    icon: Symbols.live_tv,
  ),
  thrillerMovies(
    id: 53,
    name: 'Thriller',
    mediaType: MediaType.movie,
    icon: Symbols.psychology,
  ),
  warMovies(
    id: 10752,
    name: 'War',
    mediaType: MediaType.movie,
    icon: Symbols.military_tech,
  ),
  westernMovies(
    id: 37,
    name: 'Western',
    mediaType: MediaType.movie,
    icon: Symbols.smoking_rooms,
  ),
  //TV SERIES
  actionAdventureSeries(
    id: 10759,
    name: 'Action & Adventure',
    mediaType: MediaType.tv,
    icon: Symbols.explore_nearby,
  ),
  animationSeries(
    id: 16,
    name: 'Animation',
    mediaType: MediaType.tv,
    icon: Symbols.animation,
  ),
  comedySeries(
    id: 35,
    name: 'Comedy',
    mediaType: MediaType.tv,
    icon: Symbols.theater_comedy,
  ),
  crimeSeries(
    id: 80,
    name: 'Crime',
    mediaType: MediaType.tv,
    icon: Symbols.gavel,
  ),
  documentarySeries(
    id: 99,
    name: 'Documentary',
    mediaType: MediaType.tv,
    icon: Symbols.library_books,
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
    icon: Symbols.magic_exchange,
  ),
  soapSeries(
    id: 10766,
    name: 'Soap',
    mediaType: MediaType.tv,
    icon: Symbols.heart_broken,
  ),
  talkSeries(
    id: 10767,
    name: 'Talk',
    mediaType: MediaType.tv,
    icon: Symbols.record_voice_over,
  ),
  warSeries(
    id: 10768,
    name: 'War & Politics',
    mediaType: MediaType.tv,
    icon: Symbols.flag_circle,
  ),
  westernSeries(
    id: 37,
    name: 'Western',
    mediaType: MediaType.tv,
    icon: Symbols.smoking_rooms,
  );

  const GenreIds({
    required this.name,
    required this.id,
    required this.mediaType,
    required this.icon,
  });

  final String name;
  final int id;
  final MediaType mediaType;
  final IconData icon;
}
