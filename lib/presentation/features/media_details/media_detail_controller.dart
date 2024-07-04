import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/routes/app_path.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailController extends StatelessWidget {
  const MediaDetailController({
    super.key,
    required this.movieId,
  });

  final String movieId;

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<MediaDetailBloc, MediaDetailState>(
        builder: (context, state) {
          return state.uiState.when(
            initial: () => Container(),
            success: () => MediaItemScreenDetails(movieId: movieId),
            error: (error) => Container(),
            loading: () => SplashPage(routePath: AppRoutePath.mediaDetails),
          );
        },
      ),
    );
  }
}
