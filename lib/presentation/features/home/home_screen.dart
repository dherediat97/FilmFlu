import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_day/bloc/media_day_bloc.dart';
import 'package:film_flu/presentation/features/media_day/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/features/media_list/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.mediaType,
  });

  final String mediaType;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MediaDayBloc>().add(const MediaDayEvent.fetchMediaDayItem());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: CustomScrollView(
        slivers: [
          const MediaDayWidget(),
          SliverList.list(
            children: [
              Column(
                children: [
                  if (widget.mediaType ==
                      MediaListConstants.movieMediaType) ...[
                    MediaList(
                      genreId: 28,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.action_movies,
                    ),
                    MediaList(
                      genreId: 12,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.adventure_movies,
                    ),
                    MediaList(
                      genreId: 35,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.comedy_movies,
                    ),
                    MediaList(
                      genreId: 80,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.crime_movies,
                    ),
                    MediaList(
                      genreId: 99,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.documental_series,
                    ),
                    MediaList(
                      genreId: 10751,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.family_movies,
                    ),
                    MediaList(
                      genreId: 14,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.fantasy_movies,
                    ),
                    MediaList(
                      genreId: 36,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.history_movies,
                    ),
                    MediaList(
                      genreId: 27,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.horror_movies,
                    ),
                    MediaList(
                      genreId: 10402,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.music_movies,
                    ),
                    MediaList(
                      genreId: 10749,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.love_movies,
                    ),
                    MediaList(
                      genreId: 878,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.fiction_movies,
                    ),
                    MediaList(
                      genreId: 10770,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.tv_movies,
                    ),
                    MediaList(
                      genreId: 53,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.thriller_movies,
                    ),
                    MediaList(
                      genreId: 10752,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.war_movies,
                    ),
                    MediaList(
                      genreId: 37,
                      mediaType: MediaListConstants.movieMediaType,
                      title: context.localizations.western_movies,
                    ),
                  ]
                  // else ...[
                  //   MediaList(
                  //     genreId: 16,
                  //     mediaType: MediaListConstants.serieMediaType,
                  //     title: context.localizations.animation_series,
                  //   ),
                  //   MediaList(
                  //     genreId: 16,
                  //     mediaType: MediaListConstants.serieMediaType,
                  //     title: context.localizations.animation_series,
                  //     languageId: 'ja-JA',
                  //   ),
                  // ],
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
