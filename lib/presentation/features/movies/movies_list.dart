import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/home/widgets/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  void initState() {
    super.initState();
    // context.read<MediaDayBloc>().add(
    //     const MediaDayEvent.fetchMediaDataDay(AppConstants.movieMediaType));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const MediaDayWidget(),
            MediaList(
              genreId: 28,
              title: context.localizations.action_movies,
            ),
            MediaList(
              genreId: 12,
              title: context.localizations.adventure_movies,
            ),
            MediaList(
              genreId: 35,
              title: context.localizations.comedy_movies,
            ),
            MediaList(
              genreId: 80,
              title: context.localizations.crime_movies,
            ),
            MediaList(
              genreId: 99,
              title: context.localizations.documental_series,
            ),
            MediaList(
              genreId: 10751,
              title: context.localizations.family_movies,
            ),
            MediaList(
              genreId: 14,
              title: context.localizations.fantasy_movies,
            ),
            MediaList(
              genreId: 36,
              title: context.localizations.history_movies,
            ),
            MediaList(
              genreId: 27,
              title: context.localizations.horror_movies,
            ),
            MediaList(
              genreId: 10402,
              title: context.localizations.music_movies,
            ),
            MediaList(
              genreId: 10749,
              title: context.localizations.love_movies,
            ),
            MediaList(
              genreId: 878,
              title: context.localizations.fiction_movies,
            ),
            MediaList(
              genreId: 10770,
              title: context.localizations.tv_movies,
            ),
            MediaList(
              genreId: 53,
              title: context.localizations.thriller_movies,
            ),
            MediaList(
              genreId: 10752,
              title: context.localizations.war_movies,
            ),
            MediaList(
              genreId: 37,
              title: context.localizations.western_movies,
            ),
          ],
        ),
      ),
    );
  }
}
