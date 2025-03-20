import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/search_filters/widgets/media_category.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SerieFiltersWidget extends StatelessWidget {
  const SerieFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.helicopter,
              categoryName: context.localizations.action_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.compass_calibration,
              categoryName: context.localizations.adventure_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.heat_pump_rounded,
              categoryName: context.localizations.love_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.animation,
              categoryName: context.localizations.animation_type,
            ),
          ],
        ),
        Column(
          children: [
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.science,
              categoryName: context.localizations.fiction_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.castle,
              categoryName: context.localizations.family_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.comedy_mask,
              categoryName: context.localizations.thriller_type,
            ),
            MediaCategory(
              onItemClick: () => addSerieFilter(),
              categoryIcon: Symbols.filter_drama,
              categoryName: context.localizations.drama_type,
            ),
          ],
        ),
      ],
    );
  }

  addSerieFilter() {}
}
