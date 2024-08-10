import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search/widgets/media_category.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MovieFilters extends StatelessWidget {
  const MovieFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 6,
      children: [
        Text(context.localizations.movies),
        MediaCategory(
          categoryIcon: Symbols.helicopter,
          categoryName: context.localizations.action_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.adventure_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.heart_broken,
          categoryName: context.localizations.love_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.animation,
          categoryName: context.localizations.animation_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.science,
          categoryName: context.localizations.fiction_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.castle,
          categoryName: context.localizations.fantasy_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.comedy_mask,
          categoryName: context.localizations.thriller_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.filter_drama,
          categoryName: context.localizations.drama_movies,
        )
      ],
    );
  }
}
