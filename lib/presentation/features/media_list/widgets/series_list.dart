import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/genre_ids.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/home/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter/material.dart';

class SeriesListWidget extends StatelessWidget {
  const SeriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          // MediaList(
          //   mediaType: MediaType.tv,
          //   genreId: 18,
          //   key: const Key('18'),
          //   title: context.localizations.drama_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.tv,
          //   genreId: 10751,
          //   key: const Key('10751'),
          //   title: context.localizations.family_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.tv,
          //   genreId: 9648,
          //   key: const Key('9648'),
          //   title: context.localizations.mistery_type,
          // ),
          // MediaList(
          //   mediaType: MediaType.tv,
          //   genreId: 37,
          //   key: const Key('37'),
          //   title: context.localizations.western_type,
          // ),
        ],
      ),
    );
  }
}
