import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:flutter/material.dart';

class MediaDetailController extends StatefulWidget {
  const MediaDetailController({
    super.key,
    required this.mediaType,
    required this.mediaId,
  });

  final MediaType mediaType;
  final String mediaId;

  @override
  State<MediaDetailController> createState() => _MediaDetailControllerState();
}

class _MediaDetailControllerState extends State<MediaDetailController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<MediaDetailBloc, MediaDetailState>(
    //   listenWhen: (previous, current) {
    //     return current.uiState.isSuccess();
    //   },
    //   listener: (context, state) {},
    //   buildWhen: (previous, current) {
    //     return current.mediaItem != null;
    //   },
    //   builder: (context, state) {
    //     if (state.uiState.isSuccess()) {
    return MediaItemScreenDetails(
      mediaType: widget.mediaType.name,
      mediaId: widget.mediaId,
    );
    // } else {
    //   return SplashScreen(
    //     route: widget.mediaType == MediaType.movie
    //         ? '${AppRoutePaths.moviesRoute}/${widget.mediaId}'
    //         : '${AppRoutePaths.seriesRoute}/${widget.mediaId}',
    //   );
    // }
    //     },
    //   );
  }
}
