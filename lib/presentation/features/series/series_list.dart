import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/home/widgets/media_list.dart';
import 'package:film_flu/presentation/features/media_day/bloc/media_day_bloc.dart';
import 'package:film_flu/presentation/features/media_day/media_day_widget.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesListWidget extends StatefulWidget {
  const SeriesListWidget({super.key});

  @override
  State<SeriesListWidget> createState() => _SeriesListState();
}

class _SeriesListState extends State<SeriesListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<MediaDayBloc>().add(const MediaDayEvent.fetchMediaDataDay());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MediaDayWidget(),
            MediaList(
              genreId: 10759,
              key: const ValueKey('10759'),
              title: context.localizations.action_adventure_series,
            ),
            MediaList(
              genreId: 16,
              key: const Key('16'),
              title: context.localizations.animation_series,
            ),
            MediaList(
              genreId: 35,
              key: const Key('35'),
              title: context.localizations.comedy_series,
            ),
            MediaList(
              genreId: 80,
              key: const Key('80'),
              title: context.localizations.horror_series,
            ),
            MediaList(
              genreId: 99,
              key: const Key('99'),
              title: context.localizations.crime_series,
            ),
            MediaList(
              genreId: 18,
              key: const Key('18'),
              title: context.localizations.drama_series,
            ),
            MediaList(
              genreId: 10751,
              key: const Key('10751'),
              title: context.localizations.family_series,
            ),
            MediaList(
              genreId: 10762,
              key: const Key('10762'),
              title: context.localizations.kids_series,
            ),
            MediaList(
              genreId: 9648,
              key: const Key('9648'),
              title: context.localizations.mistery_series,
            ),
            MediaList(
              genreId: 10764,
              key: const Key('10764'),
              title: context.localizations.reality_series,
            ),
            MediaList(
              genreId: 10765,
              key: const Key('10765'),
              title: context.localizations.fiction_series,
            ),
            MediaList(
              genreId: 10768,
              key: const Key('10768'),
              title: context.localizations.war_series,
            ),
            MediaList(
              genreId: 37,
              key: const Key('37'),
              title: context.localizations.western_series,
            ),
          ],
        ),
      ),
    );
  }
}
