import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/types/ui_state.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context
        .read<HomeBloc>()
        .add(const HomeEvent.switchCategory(MediaType.movie));
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current.uiState.isLoading();
      },
      builder: (context, state) {
        Widget child;

        switch (state.mediaTypeSelected) {
          case MediaType.movie:
            child = const MoviesListWidget();
            break;
          case MediaType.tv:
            child = const SeriesListWidget();
            break;
          case MediaType.search:
            child = const SearchScreen();
            break;
        }

        return ScaffoldPage(
          fullScreenMode: false,
          routeName: AppRoutePaths.homeRoute,
          child: child,
        );
      },
    );
  }
}
