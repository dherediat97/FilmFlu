import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/genres_id.dart';
import 'package:film_flu/domain/enums/media_type.dart';
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
            genreId: GenresId.animationSeries,
            key: const Key('16'),
            title: context.localizations.animation_type,
          ),
          MediaList(
            mediaType: MediaType.tv,
            genreId: GenresId.comedySeries,
            key: const Key('35'),
            title: context.localizations.comedy_type,
          ),
          MediaList(
            mediaType: MediaType.tv,
            genreId: GenresId.dramaSeries,
            key: const Key('80'),
            title: context.localizations.drama_type,
          ),
          // MediaList(
          //   mediaType: MediaType.tv,
          //   genreId: 99,
          //   key: const Key('99'),
          //   title: context.localizations.crime_type,
          // ),
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
