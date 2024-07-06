import 'package:auto_size_text/auto_size_text.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/media_list/widgets/media_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        isSearchVisible: true,
        fabLocation: FloatingActionButtonLocation.endFloat,
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
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MediaList(
                    items: state.movieList ?? [],
                  ),
                  const SizedBox(height: 20),
                  AutoSizeText(
                    context.localizations.tv_series_list_title,
                    maxFontSize: 30,
                    minFontSize: 20,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MediaList(
                    items: state.tvSeriesList ?? [],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
