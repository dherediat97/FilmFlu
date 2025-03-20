import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search_filters/widgets/movie_filters.dart';
import 'package:film_flu/presentation/features/search_filters/widgets/serie_filters.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Text(
            context.localizations.movies,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const MovieFiltersWidget(),
          Text(
            context.localizations.series,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SerieFiltersWidget(),
        ],
      ),
    );
  }
}
