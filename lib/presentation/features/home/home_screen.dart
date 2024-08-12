import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/movies/movies_list.dart';
import 'package:film_flu/presentation/features/series/series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state.mediaTypeSelected) {
          MediaType.movie => const MoviesListWidget(),
          MediaType.tv => const SeriesListWidget(),
          MediaType.search => Container(),
        };
      },
    );
  }
}
