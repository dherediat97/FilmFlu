import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search/bloc/search_bloc.dart';
import 'package:film_flu/presentation/features/search/widgets/media_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class SerieFiltersWidget extends StatelessWidget {
  const SerieFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.helicopter,
              categoryName: context.localizations.action_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.compass_calibration,
              categoryName: context.localizations.adventure_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.heat_pump_rounded,
              categoryName: context.localizations.love_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.animation,
              categoryName: context.localizations.animation_type,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.science,
              categoryName: context.localizations.fiction_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.castle,
              categoryName: context.localizations.family_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.comedy_mask,
              categoryName: context.localizations.thriller_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(context),
              categoryIcon: Symbols.filter_drama,
              categoryName: context.localizations.drama_type,
            ),
          ],
        )
      ],
    );
  }

  addSerieFilter(BuildContext context) {
    context
        .read<SearchBloc>()
        .add(const SearchEvent.addSerieFilters(SerieFilters(
          isActionSeriesFiltered: true,
        )));
  }
}
