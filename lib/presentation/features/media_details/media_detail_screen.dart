import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/presentation/features/media_details/widgets/detail_tab_media_item.dart';
import 'package:film_flu/presentation/notifiers/models/media_item_states.dart';
import 'package:film_flu/presentation/notifiers/media_detail_notifier.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaItemScreenDetails extends ConsumerStatefulWidget {
  const MediaItemScreenDetails({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });

  final String mediaId;
  final String mediaType;

  @override
  ConsumerState<MediaItemScreenDetails> createState() =>
      _MovieDetailsPageState();
}

class _MovieDetailsPageState extends ConsumerState<MediaItemScreenDetails> {
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
    var state = ref.watch(getHomeMediaDetailProvider(MediaItemState(
      mediaType: widget.mediaType,
      id: widget.mediaId,
      languageName: 'es',
    )));

    return ScaffoldPage(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.mediaType == MediaType.movie.name)
                FloatingActionButton.extended(
                  heroTag: 'buyTickets',
                  foregroundColor: AppColors.primaryColor,
                  backgroundColor: AppColors.backgroundColorLight,
                  onPressed: () {
                    context.go(AppRoutePaths.horusVisionRoute);
                  },
                  icon: const Icon(Icons.local_movies_outlined),
                  label: Text(context.localizations.buy_tickets),
                ),
              const SizedBox(
                height: 20,
              ),
              if (state.value?.trailerId != null)
                FloatingActionButton.extended(
                    heroTag: 'playTrailer',
                    icon: const Icon(Icons.play_arrow),
                    label: Text(context.localizations.play_trailer),
                    onPressed: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          dialogContext = context;

                          _trailerController = initTrailerController();

                          if (state.value?.mediaItem?.videos!.results.length !=
                              1) {
                            _trailerController?.loadPlaylist(
                              list: state.value!.mediaItem!.videos!.results
                                  .map(
                                    (e) => e.key,
                                  )
                                  .toList(),
                              index: state.value?.mediaItem!.videos!.results
                                  .indexWhere(
                                (element) =>
                                    element.key == state.value?.trailerId,
                              ),
                            );
                          } else {
                            _trailerController?.loadVideoById(
                              videoId: state.value!.trailerId!,
                            );
                          }

                          return AlertDialog.adaptive(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => closeTrailer(dialogContext),
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
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      if (kIsWeb &&
                                          constraints.maxWidth > 750) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 10,
                                              child: player,
                                            ),
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
                    })
              else
                Container(),
            ],
          ),
        ),
        child: DetailTabMediaItem(
          mediaTypeSelected: widget.mediaType,
          mediaItemId: widget.mediaId,
        ));
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

  closeTrailer(BuildContext dialogContext) {
    _trailerController = null;
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    Navigator.pop(dialogContext);
  }
}
