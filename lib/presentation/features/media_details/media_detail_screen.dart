import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_cast_list.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:film_flu/presentation/widgets/default_circular_loader.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
        MediaItemEntity? movie = state.mediaItem;

        return movie != null
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
                                              movie,
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
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken,
                                  ),
                                  image: Image.network(
                                    '${AppUrls.movieLandscapeBaseUrl}${movie.backdropPath}',
                                    loadingBuilder: (_, child, progress) =>
                                        DefaultCircularLoader(
                                            progress: progress, child: child),
                                  ).image,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          state.movieName,
                                          maxLines: 4,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 32,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            context.localizations.synopsis,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: AutoSizeText(
                                              movie.overview ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 20,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: SegmentedButton<bool>(
                                showSelectedIcon: false,
                                selected: <bool>{state.isCastSelected},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return AppColors.primaryColor;
                                      }
                                      return Colors.white24;
                                    },
                                  ),
                                ),
                                segments: [
                                  if (movie.credits?.cast.isNotEmpty == true)
                                    ButtonSegment(
                                      label: Text(
                                        context.localizations.character_cast,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      value: true,
                                    ),
                                  if (movie.credits?.crew.isNotEmpty == true)
                                    ButtonSegment(
                                      label: Text(
                                        context.localizations.production_cast,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      value: false,
                                    ),
                                ],
                                onSelectionChanged: (Set<bool> castSelected) {
                                  context
                                      .read<MediaDetailBloc>()
                                      .add(MediaDetailEvent.setCreditsType(
                                        castSelected.first,
                                      ));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            state.isCastSelected
                                ? FilmCast(
                                    movieId: widget.mediaTypeId.toString(),
                                    isCast: true,
                                    mediaType: AppConstants.mediaType,
                                    cast: movie.credits!.cast,
                                    crew: movie.credits!.crew,
                                  )
                                : FilmCast(
                                    movieId: widget.mediaTypeId.toString(),
                                    isCast: false,
                                    mediaType: AppConstants.mediaType,
                                    cast: movie.credits!.cast,
                                    crew: movie.credits!.crew,
                                  )
                          ],
                        ),
                      )
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
