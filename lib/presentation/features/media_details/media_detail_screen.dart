import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/detail_tab_media_item.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaItemScreenDetails extends StatefulWidget {
  const MediaItemScreenDetails({
    super.key,
    required this.mediaTypeId,
  });

  final String mediaTypeId;

  @override
  State<MediaItemScreenDetails> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MediaItemScreenDetails> {
  YoutubePlayerController? _trailerController;

  @override
  void initState() {
    super.initState();
    _trailerController = initTrailerController();
    _trailerController?.toggleFullScreen(lock: false);
  }

  @override
  void dispose() {
    _trailerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext dialogContext;

    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        MediaType mediaTypeSelected =
            context.read<HomeBloc>().state.mediaTypeSelected;

        return ScaffoldPage(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    foregroundColor: AppColors.primaryColor,
                    backgroundColor: AppColors.backgroundColorLight,
                    onPressed: () {
                      // context.go(AppRoutePaths.horusVisionRoute);
                    },
                    icon: const Icon(Icons.local_movies_outlined),
                    label: Text(context.localizations.buy_tickets),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state.trailerId.isNotEmpty
                      ? FloatingActionButton.extended(
                          icon: const Icon(Icons.play_arrow),
                          label: Text(context.localizations.play_trailer),
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                dialogContext = context;
                                context
                                    .read<MediaDetailBloc>()
                                    .add(const MediaDetailEvent.openTrailer());
                                _trailerController = initTrailerController();
                                if (state.trailerId.isNotEmpty) {
                                  _trailerController?.loadVideoById(
                                    videoId: state.trailerId.toString(),
                                  );
                                }
                                return AlertDialog.adaptive(
                                  icon: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            closeTrailer(dialogContext),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  content: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: YoutubePlayerScaffold(
                                      aspectRatio: 100.0,
                                      controller: _trailerController!,
                                      builder: (context, player) {
                                        return player;
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            child: DetailTabMediaItem(
              mediaTypeSelected: mediaTypeSelected,
              mediaItemId: state.mediaItem?.id.toString(),
            ));
      },
    );
  }

  initTrailerController() {
    // await horus_vision.initDi();
    return YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: false,
        showVideoAnnotations: false,
        captionLanguage: 'es',
        enableKeyboard: false,
        interfaceLanguage: 'es',
        strictRelatedVideos: true,
        loop: true,
        pointerEvents: PointerEvents.none,
        playsInline: true,
        enableCaption: false,
        showFullscreenButton: true,
      ),
    );
  }

  closeTrailer(dialogContext) {
    context.read<MediaDetailBloc>().add(const MediaDetailEvent.closeTrailer());
    _trailerController = null;
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    Navigator.pop(dialogContext!);
  }
}
