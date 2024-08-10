import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/home/bloc/home_bloc.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
    _trailerController = null;
  }

  @override
  Widget build(BuildContext context) {
    BuildContext dialogContext;

    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        MediaItemEntity? mediaItem = state.mediaItem;
        MediaType mediaTypeSelected =
            mediaItem?.title != '' ? MediaType.movie : MediaType.tv;

        return ScaffoldPage(
          isSearchVisible: true,
          fabLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(4.0),
            child: state.trailerId.isNotEmpty
                ? !state.isTrailerOpened
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
                    : Container()
                : Container(),
          ),
          child: DetailTabMediaItem(
            mediaTypeSelected: mediaTypeSelected,
            mediaItemId: state.mediaItem?.id ?? 0,
          ),
        );
      },
    );
  }

  initTrailerController() {
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
