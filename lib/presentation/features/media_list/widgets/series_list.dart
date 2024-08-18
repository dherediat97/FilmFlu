import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/home/widgets/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesListWidget extends StatelessWidget {
  const SeriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (context, state) {
        return ScaffoldPage(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MediaDayWidget(),
                MediaList(
                  genreId: 16,
                  key: const Key('16'),
                  title: context.localizations.animation_type,
                ),
                MediaList(
                  genreId: 35,
                  key: const Key('35'),
                  title: context.localizations.comedy_type,
                ),
                MediaList(
                  genreId: 80,
                  key: const Key('80'),
                  title: context.localizations.horror_type,
                ),
                MediaList(
                  genreId: 99,
                  key: const Key('99'),
                  title: context.localizations.crime_type,
                ),
                MediaList(
                  genreId: 18,
                  key: const Key('18'),
                  title: context.localizations.drama_type,
                ),
                MediaList(
                  genreId: 10751,
                  key: const Key('10751'),
                  title: context.localizations.family_type,
                ),
                MediaList(
                  genreId: 9648,
                  key: const Key('9648'),
                  title: context.localizations.mistery_type,
                ),
                MediaList(
                  genreId: 37,
                  key: const Key('37'),
                  title: context.localizations.western_type,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
