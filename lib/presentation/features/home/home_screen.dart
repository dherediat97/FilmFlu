import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            MediaList(
              genreId: 28,
              mediaType: MediaListConstants.movieMediaType,
              title: context.localizations.action_movies,
            ),
            MediaList(
              genreId: 35,
              mediaType: MediaListConstants.movieMediaType,
              title: context.localizations.comedy_movies,
            ),
            MediaList(
              genreId: 16,
              mediaType: MediaListConstants.serieMediaType,
              title: context.localizations.anime_series,
            ),
            MediaList(
              genreId: 10749,
              mediaType: MediaListConstants.movieMediaType,
              title: context.localizations.love_movies,
            ),
            MediaList(
              genreId: 53,
              mediaType: MediaListConstants.movieMediaType,
              title: context.localizations.drama_movies,
            ),
            MediaList(
              genreId: 878,
              mediaType: MediaListConstants.movieMediaType,
              title: context.localizations.fiction_movies,
            ),
            MediaList(
              genreId: 10767,
              mediaType: MediaListConstants.serieMediaType,
              title: context.localizations.tv_show_series,
            ),
            MediaList(
              genreId: 99,
              mediaType: MediaListConstants.serieMediaType,
              title: context.localizations.documental_series,
            ),
          ],
        )),
      ),
    );
  }
}
