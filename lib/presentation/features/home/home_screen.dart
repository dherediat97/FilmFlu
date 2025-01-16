import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/search/search_screen.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget child = const MoviesListWidget();
    final state = ref.watch(switchCategoryProvider(MediaType.movie));

    return state.when(
      data: (data) {
        switch (data.mediaTypeSelected) {
          case MediaType.movie:
            child = const MoviesListWidget();
            break;
          case MediaType.tv:
            child = const SeriesListWidget();
            break;
          default:
            child = const SearchScreen();
            break;
        }
        return ScaffoldPage(
          fullScreenMode: false,
          routeName: AppRoutePaths.homeRoute,
          child: child,
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
