import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search/widgets/movie_filters.dart';
import 'package:film_flu/presentation/features/search/widgets/serie_filters.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }
}
