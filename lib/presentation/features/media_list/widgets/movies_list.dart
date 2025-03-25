import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
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
            genreId: GenreIds.adventure,
            key: Key(GenreIds.adventure.name),
            title: context.localizations.adventure_type,
          ),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenreIds.dramaMovies,
            key: Key(GenreIds.dramaMovies.name),
            title: context.localizations.drama_type,
          ),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenreIds.thrillerMovies,
            key: Key(GenreIds.thrillerMovies.name),
            title: context.localizations.thriller_type,
          ),
          MediaList(
            mediaType: MediaType.movie,
            genreId: GenreIds.scifiMovies,
            key: Key(GenreIds.scifiMovies.name),
            title: context.localizations.fiction_type,
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
