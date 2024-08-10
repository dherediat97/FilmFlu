import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaDetailController extends StatefulWidget {
  const MediaDetailController({
    super.key,
    required this.mediaType,
    required this.mediaTypeId,
  });

  final String mediaType;
  final String mediaTypeId;

  @override
  State<MediaDetailController> createState() => _MediaDetailControllerState();
}

class _MediaDetailControllerState extends State<MediaDetailController> {
  @override
  void initState() {
    super.initState();
    context.read<MediaDetailBloc>().add(MediaDetailEvent.getMediaDetails(
          MediaType.movie,
          widget.mediaTypeId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        return state.uiState.when(
          initial: () => Container(),
          success: () =>
              MediaItemScreenDetails(mediaTypeId: widget.mediaTypeId),
          error: (error) => Container(),
          loading: () => SplashScreen(
            route:
                '${AppRoutePaths.mediaDetailsRoute}/${widget.mediaType}/${widget.mediaTypeId}',
          ),
        );
      },
    );
  }
}
