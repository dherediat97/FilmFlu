import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:flutter/material.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MediaList(
            genreId: 10759,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.action_adventure_series,
          ),
          MediaList(
            genreId: 16,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.animation_series,
          ),
          MediaList(
            genreId: 35,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.comedy_series,
          ),
          MediaList(
            genreId: 80,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.horror_series,
          ),
          MediaList(
            genreId: 99,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.crime_series,
          ),
          MediaList(
            genreId: 18,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.drama_series,
          ),
          MediaList(
            genreId: 10751,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.family_series,
          ),
          MediaList(
            genreId: 10762,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.kids_series,
          ),
          MediaList(
            genreId: 9648,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.mistery_series,
          ),
          MediaList(
            genreId: 10764,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.reality_series,
          ),
          MediaList(
            genreId: 10765,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.fiction_series,
          ),
          MediaList(
            genreId: 10767,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.talk_series,
          ),
          MediaList(
            genreId: 10768,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.war_series,
          ),
          MediaList(
            genreId: 37,
            mediaType: MediaListConstants.serieMediaType,
            title: context.localizations.western_series,
          ),
        ],
      ),
    );
  }
}
