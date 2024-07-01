import 'package:FilmFlu/app/extensions/localizations_extensions.dart';
import 'package:FilmFlu/app/types/ui_state.dart';
import 'package:FilmFlu/presentation/features/movie_list/bloc/media_list_bloc.dart';
import 'package:FilmFlu/presentation/features/movie_list/widgets/movie_list.dart';
import 'package:FilmFlu/presentation/features/scaffold_page/custom_scaffold_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _moviesScrollController = ScrollController();

  final _tvSeriesScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      isSearchVisible: true,
      fabLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer,
                ])),
            child: const Icon(
              Icons.search,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
      isLightsOn: true,
      containerChild: BlocBuilder<MediaListBloc, MediaListState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  context.localizations.film_list_title,
                  maxFontSize: 30,
                  minFontSize: 20,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    thickness: 3,
                    controller: _moviesScrollController,
                    child: state.uiState.isLoading()
                        ? const Center(child: CircularProgressIndicator())
                        : MovieList(
                            items: state.movieList ?? [],
                            scrollController: _moviesScrollController,
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                AutoSizeText(
                  context.localizations.tv_series_list_title,
                  maxFontSize: 30,
                  minFontSize: 20,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Scrollbar(
                    thickness: 3,
                    controller: _tvSeriesScrollController,
                    child: state.uiState.isLoading()
                        ? const Center(child: CircularProgressIndicator())
                        : MovieList(
                            items: state.tvSeriesList ?? [],
                            scrollController: _tvSeriesScrollController,
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
