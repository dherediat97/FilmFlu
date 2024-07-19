import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/credits_widget.dart';
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

        return mediaItem != null
            ? ScaffoldPage(
                isSearchVisible: true,
                fullScreenMode: state.isTrailerOpened,
                fabLocation: FloatingActionButtonLocation.endFloat,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // FloatingActionButton.extended(
                      //   label: const Text('Comprar entradas'),
                      //   icon: const Icon(Icons.shopping_bag_rounded),
                      //   onPressed: () {
                      //     context.push('/horusVision');
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      state.trailerId.isNotEmpty
                          ? Container(
                              child: state.isTrailerOpened
                                  ? FloatingActionButton(
                                      mini: true,
                                      child: const Icon(Icons.stop),
                                      onPressed: () {
                                        context.read<MediaDetailBloc>().add(
                                            const MediaDetailEvent
                                                .closeTrailer());
                                        _trailerController = null;
                                        SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.edgeToEdge,
                                        );
                                      },
                                    )
                                  : FloatingActionButton.extended(
                                      icon: const Icon(Icons.play_arrow),
                                      label: const Text('Ver trailer'),
                                      onPressed: () {
                                        context
                                            .read<MediaDetailBloc>()
                                            .add(MediaDetailEvent.openTrailer(
                                              AppConstants.mediaType,
                                              mediaItem,
                                            ));
                                        _trailerController =
                                            initTrailerController();
                                        if (state.trailerId.isNotEmpty) {
                                          _trailerController?.loadVideoById(
                                            videoId: state.trailerId.toString(),
                                          );
                                        }
                                      },
                                    ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                child: !state.isTrailerOpened
                    ? const CreditsWidget()
                    : YoutubePlayerScaffold(
                        controller: _trailerController!,
                        builder: (context, player) {
                          return Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.only(top: 50),
                                child: player,
                              ),
                            ],
                          );
                        },
                      ),
              )
            : const Center(
                child: CircularProgressIndicator(),
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
