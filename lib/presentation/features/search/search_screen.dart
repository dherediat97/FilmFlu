import 'package:film_flu/presentation/features/search/widgets/movie_filters.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(child: MovieFilters());
  }
}
