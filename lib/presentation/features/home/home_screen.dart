import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/home/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/home/widgets/series_list.dart';
import 'package:film_flu/presentation/features/media_day/bloc/media_day_bloc.dart';
import 'package:film_flu/presentation/features/media_day/media_day_widget.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadMovieDay();
    _tabController.addListener(
      () {
        var index = _tabController.index;
        switch (index) {
          case 0:
            loadMovieDay();
            break;
          case 1:
            loadSerieDay();
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: CustomScrollView(
        slivers: [
          MediaDayWidget(isMovie: _tabController.index == 0),
          SliverList.list(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: context.localizations.movies),
                  Tab(text: context.localizations.series),
                ],
              ),
              SizedBox(
                height: 1000,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    MoviesList(),
                    SeriesList(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  loadMovieDay() {
    AppConstants.mediaType = MediaListConstants.movieMediaType;
    context.read<MediaDayBloc>().add(const MediaDayEvent.fetchMovieDay());
  }

  loadSerieDay() {
    AppConstants.mediaType = MediaListConstants.serieMediaType;
    context.read<MediaDayBloc>().add(const MediaDayEvent.fetchSerieDay());
  }
}
