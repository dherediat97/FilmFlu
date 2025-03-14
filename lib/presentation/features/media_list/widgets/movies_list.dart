import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/data/enums/genres_id.dart';
import 'package:film_flu/data/enums/media_type.dart';
import 'package:film_flu/presentation/features/home/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter/material.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          MediaDayWidget(mediaTypeSelected: MediaType.movie),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenresId.actionMovies,
            key: const Key('28'),
            title: context.localizations.action_type,
          ),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenresId.adventure,
            key: const Key('12'),
            title: context.localizations.adventure_type,
          ),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenresId.comedyMovies,
            key: const Key('35'),
            title: context.localizations.comedy_type,
          ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 80,
          //   key: const Key('80'),
          //   title: context.localizations.crime_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 99,
          //   key: const Key('99'),
          //   title: context.localizations.documentary_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 10751,
          //   key: const Key('10751'),
          //   title: context.localizations.family_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 14,
          //   key: const Key('14'),
          //   title: context.localizations.fantasy_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 36,
          //   key: const Key('36'),
          //   title: context.localizations.history_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 27,
          //   key: const Key('27'),
          //   title: context.localizations.horror_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 10402,
          //   key: const Key('10402'),
          //   title: context.localizations.music_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 10749,
          //   key: const Key('10749'),
          //   title: context.localizations.love_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 878,
          //   key: const Key('878'),
          //   title: context.localizations.fiction_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 10770,
          //   key: const Key('10770'),
          //   title: context.localizations.tv_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 53,
          //   key: const Key('53'),
          //   title: context.localizations.thriller_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 10752,
          //   key: const Key('10752'),
          //   title: context.localizations.war_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.movie,
          //   genreId: 37,
          //   key: const Key('37'),
          //   title: context.localizations.western_type,
          // ),
        ],
      ),
    );
  }
}
