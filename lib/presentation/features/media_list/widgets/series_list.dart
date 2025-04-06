import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/notifiers/media_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeriesListWidget extends ConsumerStatefulWidget {
  const SeriesListWidget({super.key});

  @override
  ConsumerState<SeriesListWidget> createState() => _SeriesListWidgetState();
}

class _SeriesListWidgetState extends ConsumerState<SeriesListWidget> {
  MediaListPage get mediaListNotifier =>
      ref.watch(mediaListPageProvider.notifier);
  int get pageLoaded => ref.watch(mediaListPageProvider);

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
            MediaDayWidget(mediaTypeSelected: MediaType.tv),
            MediaList(
              mediaType: MediaType.tv,
              genreId: GenreIds.actionAdventureSeries,
              key: Key(GenreIds.actionAdventureSeries.name),
              title: context.localizations.action_type,
            ),
            MediaList(
              mediaType: MediaType.tv,
              genreId: GenreIds.comedySeries,
              key: Key(GenreIds.comedySeries.name),
              title: context.localizations.comedy_type,
            ),
            MediaList(
              mediaType: MediaType.tv,
              genreId: GenreIds.sciFiFantasySeries,
              key: Key(GenreIds.sciFiFantasySeries.name),
              title: context.localizations.fiction_type,
            ),

            if (pageLoaded >= 2) ...[
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.familySeries,
                key: Key(GenreIds.familySeries.name),
                title: context.localizations.family_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.animationMovies,
                key: Key(GenreIds.animationMovies.name),
                title: context.localizations.animation_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.kidsSeries,
                key: Key(GenreIds.kidsSeries.name),
                title: context.localizations.child_animation_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.documentarySeries,
                key: Key(GenreIds.documentarySeries.name),
                title: context.localizations.documentary_type,
              ),
            ],
            if (pageLoaded >= 3) ...[
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.mysterySeries,
                key: Key(GenreIds.mysteryMovies.name),
                title: context.localizations.mistery_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.crimeSeries,
                key: Key(GenreIds.crimeSeries.name),
                title: context.localizations.crime_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.warSeries,
                key: Key(GenreIds.warSeries.name),
                title: context.localizations.war_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.realitySeries,
                key: Key(GenreIds.realitySeries.name),
                title: context.localizations.reality_type,
              ),
              MediaList(
                mediaType: MediaType.tv,
                genreId: GenreIds.talkSeries,
                key: Key(GenreIds.talkSeries.name),
                title: context.localizations.tv_type,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
