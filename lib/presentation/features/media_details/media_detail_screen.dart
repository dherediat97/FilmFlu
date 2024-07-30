import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/detail_tab_media_item.dart';
import 'package:film_flu/presentation/features/media_list/constants/media_list_constants.dart';
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
    return BlocBuilder<MediaDetailBloc, MediaDetailState>(
      builder: (context, state) {
        MediaItemEntity? mediaItem = state.mediaItem;
        String mediaItemType = mediaItem?.title != ''
            ? MediaListConstants.movieMediaType
            : MediaListConstants.serieMediaType;

        return ScaffoldPage(
          isSearchVisible: true,
          fullScreenMode: state.isTrailerOpened,
          fabLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.trailerId.isNotEmpty
                ? Container(
                    child: state.isTrailerOpened
                        ? FloatingActionButton(
                            mini: true,
                            child: const Icon(Icons.stop),
                            onPressed: () {
                              context
                                  .read<MediaDetailBloc>()
                                  .add(const MediaDetailEvent.closeTrailer());
                              _trailerController = null;
                              SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.edgeToEdge,
                              );
                            },
                          )
                        : FloatingActionButton.extended(
                            icon: const Icon(Icons.play_arrow),
                            label: Text(context.localizations.play_trailer),
                            onPressed: () {
                              context
                                  .read<MediaDetailBloc>()
                                  .add(MediaDetailEvent.openTrailer(
                                    AppConstants.mediaType,
                                    mediaItem!,
                                  ));
                              _trailerController = initTrailerController();
                              if (state.trailerId.isNotEmpty) {
                                _trailerController?.loadVideoById(
                                  videoId: state.trailerId.toString(),
                                );
                              }
                            },
                          ),
                  )
                : Container(),
          ),
          child: !state.isTrailerOpened
              ? DetailTabMediaItem(
                  mediaItemType: mediaItemType,
                  mediaItemId: state.mediaItem!.id,
                )
              : YoutubePlayerScaffold(
                  controller: _trailerController!,
                  builder: (context, player) {
                    return player;
                  },
                ),
        );
      },
    );
  }
}

YoutubePlayerController initTrailerController() {
  return YoutubePlayerController(
    params: const YoutubePlayerParams(
      showControls: false,
      showVideoAnnotations: false,
      captionLanguage: 'es',
      enableKeyboard: false,
      interfaceLanguage: 'es',
      playsInline: true,
    ),
  );
}
