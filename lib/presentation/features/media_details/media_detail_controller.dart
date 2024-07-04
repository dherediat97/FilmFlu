import 'package:FilmFlu/app/di/top_bloc_providers.dart';
import 'package:FilmFlu/app/routes/app_path.dart';
import 'package:FilmFlu/domain/models/details_movie_arguments.dart';
import 'package:FilmFlu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:FilmFlu/presentation/features/media_details/media_detail_screen.dart';
import 'package:FilmFlu/presentation/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailController extends StatelessWidget {
  const MediaDetailController({
    super.key,
    required this.movieArguments,
  });

  final DetailsMovieArguments movieArguments;

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<MediaDetailBloc, MediaDetailState>(
        builder: (context, state) {
          return state.uiState.when(
            initial: () => Container(),
            success: () => MediaItemScreenDetails(
              movieArguments: movieArguments,
            ),
            error: (error) => Container(),
            loading: () => SplashPage(routePath: AppRoutePath.mediaDetails),
          );
        },
      ),
    );
  }
}
