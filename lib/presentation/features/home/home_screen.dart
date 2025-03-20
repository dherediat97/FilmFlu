import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/person_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/notifiers/home_notifier.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/domain/enums/media_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget child = const MoviesListWidget();
    final state = ref.watch(homeProvider);

    switch (state) {
      case MediaType.movie:
        child = const MoviesListWidget();
        break;
      case MediaType.tv:
        child = const SeriesListWidget();
        break;
      default:
        child = const PersonListWidget();
        break;
    }
    return ScaffoldPage(child: child);
  }
}
