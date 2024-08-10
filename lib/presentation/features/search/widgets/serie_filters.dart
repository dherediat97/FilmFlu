import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search/widgets/media_category.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SerieFilters extends StatelessWidget {
  const SerieFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 6,
      children: [
        Text(context.localizations.series),
        MediaCategory(
          categoryIcon: Symbols.helicopter,
          categoryName: context.localizations.action_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.adventure_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.love_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.animation_series,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.fiction_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.fantasy_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.thriller_movies,
        ),
        MediaCategory(
          categoryIcon: Symbols.compass_calibration,
          categoryName: context.localizations.drama_movies,
        )
      ],
    );
  }
}
