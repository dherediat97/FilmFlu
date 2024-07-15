import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailController extends StatelessWidget {
  const MediaDetailController({
    super.key,
    required this.mediaTypeId,
  });

  final String mediaTypeId;

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<MediaDetailBloc, MediaDetailState>(
        builder: (context, state) {
          return state.uiState.when(
            initial: () => Container(),
            success: () => MediaItemScreenDetails(mediaTypeId: mediaTypeId),
            error: (error) => Container(),
            loading: () => SplashScreen(
              route: '${AppRoutePaths.mediaDetailsRoute}/$mediaTypeId',
            ),
          );
        },
      ),
    );
  }
}
