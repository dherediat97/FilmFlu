import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/notifiers/media_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesListWidget extends ConsumerStatefulWidget {
  const MoviesListWidget({super.key, this.userToken = ''});
  final String userToken;

  @override
  ConsumerState<MoviesListWidget> createState() => _MoviesListWidgetState();
}

class _MoviesListWidgetState extends ConsumerState<MoviesListWidget> {
  MediaListPage get mediaListNotifier =>
      ref.read(mediaListPageProvider.notifier);
  int get pageLoaded => ref.watch(mediaListPageProvider);

  @override
  void initState() {
    if (widget.userToken.isNotEmpty) {
      mediaListNotifier.createSession(widget.userToken);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.axisDirection == AxisDirection.down &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
          mediaListNotifier.loadNewPage();
        }
        return true;
      },
      child: SingleChildScrollView(
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
              genreId: GenreIds.actionMovies,
              key: Key(GenreIds.actionMovies.name),
              title: context.localizations.action_type,
            ),
            MediaList(
              mediaType: MediaType.movie,
              genreId: GenreIds.fantasyMovies,
              key: Key(GenreIds.fantasyMovies.name),
              title: context.localizations.fantasy_type,
            ),
            MediaList(
              mediaType: MediaType.movie,
              genreId: GenreIds.scifiMovies,
              key: Key(GenreIds.scifiMovies.name),
              title: context.localizations.fiction_type,
            ),

            if (pageLoaded >= 2) ...[
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.familyMovies,
                key: Key(GenreIds.familyMovies.name),
                title: context.localizations.family_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.romanceMovies,
                key: Key(GenreIds.romanceMovies.name),
                title: context.localizations.love_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.comedyMovies,
                key: Key(GenreIds.comedyMovies.name),
                title: context.localizations.comedy_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.musicMovies,
                key: Key(GenreIds.musicMovies.name),
                title: context.localizations.music_type,
              ),
            ],
            if (pageLoaded >= 3) ...[
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.mysteryMovies,
                key: Key(GenreIds.mysteryMovies.name),
                title: context.localizations.mistery_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.thrillerMovies,
                key: Key(GenreIds.thrillerMovies.name),
                title: context.localizations.thriller_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.crimeMovies,
                key: Key(GenreIds.crimeMovies.name),
                title: context.localizations.crime_type,
              ),
              MediaList(
                mediaType: MediaType.movie,
                genreId: GenreIds.horrorMovies,
                key: Key(GenreIds.horrorMovies.name),
                title: context.localizations.horror_type,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
