import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search/widgets/media_category.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MovieFiltersWidget extends StatelessWidget {
  const MovieFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.helicopter,
              categoryName: context.localizations.action_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.compass_calibration,
              categoryName: context.localizations.adventure_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.heat_pump_rounded,
              categoryName: context.localizations.love_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.animation,
              categoryName: context.localizations.animation_type,
            ),
          ],
        ),
        Column(
          children: [
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.science,
              categoryName: context.localizations.fiction_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.castle,
              categoryName: context.localizations.fantasy_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.comedy_mask,
              categoryName: context.localizations.thriller_type,
            ),
            MediaCategory(
              onItemClick: () => addMovieFilter(context),
              categoryIcon: Symbols.filter_drama,
              categoryName: context.localizations.drama_type,
            ),
          ],
        )
      ],
    );
  }

  addMovieFilter(BuildContext context) {
    // context
    //     .read<SearchBloc>()
    //     .add(const SearchEvent.addMovieFilters(MovieFilters(
    //       isActionMovieFiltered: true,
    //     )));
  }
}
