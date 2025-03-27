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
        ],
      ),
    );
  }
}
