import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/home/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter/material.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MediaDayWidget(),
          MediaList(
            genreId: 28,
            title: context.localizations.action_type,
          ),
          MediaList(
            genreId: 12,
            title: context.localizations.adventure_type,
          ),
          MediaList(
            genreId: 35,
            title: context.localizations.comedy_type,
          ),
          MediaList(
            genreId: 80,
            title: context.localizations.crime_type,
          ),
          MediaList(
            genreId: 99,
            title: context.localizations.documentary_type,
          ),
          MediaList(
            genreId: 10751,
            title: context.localizations.family_type,
          ),
          MediaList(
            genreId: 14,
            title: context.localizations.fantasy_type,
          ),
          MediaList(
            genreId: 36,
            title: context.localizations.history_type,
          ),
          MediaList(
            genreId: 27,
            title: context.localizations.horror_type,
          ),
          MediaList(
            genreId: 10402,
            title: context.localizations.music_type,
          ),
          MediaList(
            genreId: 10749,
            title: context.localizations.love_type,
          ),
          MediaList(
            genreId: 878,
            title: context.localizations.fiction_type,
          ),
          MediaList(
            genreId: 10770,
            title: context.localizations.tv_type,
          ),
          MediaList(
            genreId: 53,
            title: context.localizations.thriller_type,
          ),
          MediaList(
            genreId: 10752,
            title: context.localizations.war_type,
          ),
          MediaList(
            genreId: 37,
            title: context.localizations.western_type,
          ),
        ],
      ),
    );
  }
}
