import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MediaList(
            genreId: 28,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.action_movies,
          ),
          MediaList(
            genreId: 12,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.adventure_movies,
          ),
          MediaList(
            genreId: 35,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.comedy_movies,
          ),
          MediaList(
            genreId: 80,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.crime_movies,
          ),
          MediaList(
            genreId: 99,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.documental_series,
          ),
          MediaList(
            genreId: 10751,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.family_movies,
          ),
          MediaList(
            genreId: 14,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.fantasy_movies,
          ),
          MediaList(
            genreId: 36,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.history_movies,
          ),
          MediaList(
            genreId: 27,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.horror_movies,
          ),
          MediaList(
            genreId: 10402,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.music_movies,
          ),
          MediaList(
            genreId: 10749,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.love_movies,
          ),
          MediaList(
            genreId: 878,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.fiction_movies,
          ),
          MediaList(
            genreId: 10770,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.tv_movies,
          ),
          MediaList(
            genreId: 53,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.thriller_movies,
          ),
          MediaList(
            genreId: 10752,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.war_movies,
          ),
          MediaList(
            genreId: 37,
            mediaType: MediaListConstants.movieMediaType,
            title: context.localizations.western_movies,
          ),
        ],
      ),
    );
  }
}
