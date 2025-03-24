import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/features/media_details/widgets/detail_tab_media_item.dart';
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaItemScreenDetails extends ConsumerStatefulWidget {
  const MediaItemScreenDetails({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.languageCode,
  });

  final String mediaId;
  final String mediaType;
  final String languageCode;

  @override
  ConsumerState<MediaItemScreenDetails> createState() =>
      _MovieDetailsPageState();
}

class _MovieDetailsPageState extends ConsumerState<MediaItemScreenDetails> {
  late YoutubePlayerController _trailerController;

  @override
  void initState() {
    super.initState();
    _trailerController = initTrailerController();
    _trailerController.toggleFullScreen(lock: false);
  }

  @override
  void dispose() {
    closeTrailer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext dialogContext;
    final state = ref.watch(
      getHomeMediaDetailProvider(
        MediaItemState(
          mediaType: widget.mediaType,
          id: widget.mediaId,
          languageName: widget.languageCode,
        ),
      ),
    );

    final trailerDetails = state;

    return ScaffoldPage(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // if (widget.mediaType == MediaType.movie.name)
            //   FloatingActionButton.extended(
            //     heroTag: 'buyTickets',
            //     foregroundColor: AppColors.primaryColor,
            //     backgroundColor: AppColors.backgroundColorLight,
            //     onPressed: () {
            //       context.go(AppRoutePaths.horusVisionRoute);
            //     },
            //     icon: const Icon(Icons.local_movies_outlined),
            //     label: Text(context.localizations.buy_tickets),
            //   ),
            const SizedBox(height: 20),
            trailerDetails.when(
              data: (data) {
                if (data.trailerIds.isEmpty) return Container();

                return FloatingActionButton.extended(
                  heroTag: 'playTrailer',
                  icon: const Icon(Icons.play_arrow),
                  label: Text(
                    context.localizations.play_trailer,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        dialogContext = context;

                        _trailerController = initTrailerController();
                        if (data.trailerIds.length == 1) {
                          _trailerController.loadVideoById(
                            videoId: data.trailerIds.first,
                          );
                        } else {
                          _trailerController.loadPlaylist(
                            list: data.trailerIds,
                            index: data.trailerIds.indexOf(data.trailerIds[0]),
                          );
                        }

                        return AlertDialog.adaptive(
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  closeTrailer();
                                  Navigator.pop(dialogContext);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: YoutubePlayerScaffold(
                              controller: _trailerController,
                              builder: (context, player) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (kIsWeb && constraints.maxWidth > 750) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(flex: 10, child: player),
                                        ],
                                      );
                                    }

                                    return player;
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ),
          ],
        ),
      ),
      child: DetailTabMediaItem(
        mediaTypeSelected: widget.mediaType,
        mediaItemId: widget.mediaId,
      ),
    );
  }

  initTrailerController() {
    return YoutubePlayerController(
      params: YoutubePlayerParams(
        showControls: false,
        captionLanguage: 'es',
        enableKeyboard: false,
        interfaceLanguage: 'es',
        loop: true,
        playsInline: true,
        showFullscreenButton: true,
      ),
    );
  }

  closeTrailer() {
    _trailerController.close();
    _trailerController.stopVideo();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
