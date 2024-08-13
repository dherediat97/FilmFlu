import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/types/ui_state.dart';
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
          widget.mediaType,
          widget.mediaTypeId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaDetailBloc, MediaDetailState>(
      listenWhen: (previous, current) {
        return current.uiState.isSuccess();
      },
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return current.mediaItem != previous.mediaItem;
      },
      builder: (context, state) {
        if (state.uiState.isLoading()) {
          return SplashScreen(
            route:
                '${AppRoutePaths.mediaDetailsRoute}/${widget.mediaType}/${widget.mediaTypeId}',
          );
        } else if (state.uiState.isSuccess()) {
          return MediaItemScreenDetails(mediaTypeId: widget.mediaTypeId);
        } else {
          return Container();
        }
      },
    );
  }
}
