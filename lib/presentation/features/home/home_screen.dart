import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/person_list/trending_person_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/domain/enums/media_types.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.mediaTypeSelected});

  final MediaType mediaTypeSelected;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget child = const MoviesListWidget();

    switch (widget.mediaTypeSelected) {
      case MediaType.movie:
        child = const MoviesListWidget();
        break;
      case MediaType.tv:
        child = const SeriesListWidget();
        break;
      default:
        child = const TrendingPersonListWidget();
        break;
    }
    return child;
  }
}
