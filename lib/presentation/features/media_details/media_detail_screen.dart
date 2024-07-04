import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/custom_loading.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/media_item_entity.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_details/widgets/media_cast_list.dart';
import 'package:film_flu/presentation/features/scaffold_page/custom_scaffold_page.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/constants/theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaItemScreenDetails extends StatefulWidget {
  const MediaItemScreenDetails({
    super.key,
    required this.movieId,
  });

  final String movieId;

  @override
  State<MediaItemScreenDetails> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MediaItemScreenDetails> {
  bool isCastSelected = true;
  bool isTrailerSelected = false;
  bool haveTrailer = false;
  final YoutubePlayerController _trailerController = YoutubePlayerController(
    params: const YoutubePlayerParams(
      showControls: false,
      showVideoAnnotations: false,
      captionLanguage: 'es',
      enableKeyboard: false,
      interfaceLanguage: 'es',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        isSearchVisible: true,
        isLightsOn: !isTrailerSelected,
        fabLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: isTrailerSelected
            ? FloatingActionButton(
                mini: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: const Icon(Icons.stop),
                onPressed: () {
                  setState(() {
                    _trailerController.stopVideo();
                    _trailerController.close();
                    isTrailerSelected = false;
                    SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.edgeToEdge);
                  });
                },
              )
            : FutureBuilder<bool>(
                future: Future.value(haveTrailer),
                builder: (context, snapshot) {
                  return FloatingActionButton(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isTrailerSelected = true;
                        });
                      },
                      child: const Icon(Icons.play_arrow));
                },
              ),
        containerChild: BlocBuilder<MediaDetailBloc, MediaDetailState>(
          builder: (context, state) {
            MediaItemEntity? movie = state.mediaItem;

            if (movie?.videos?.results.isNotEmpty == true) {
              _trailerController.loadVideoById(
                videoId: movie!.videos!.results
                    .firstWhere((element) =>
                        element.official && element.type == 'Trailer')
                    .key,
              );
            }

            String? movieTitle =
                movie?.title != '' ? movie?.title : movie?.name;

            if (movie == null) return Container();

            return !isTrailerSelected
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
                                loadingBuilder:
                                    (context, child, loadingProgress) =>
                                        DefaultAsyncLoading(
                                  loadingProgress: loadingProgress,
                                  child: child,
                                ),
                              ).image,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      child: AutoSizeText(
                                        movieTitle.toString(),
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'YsabeauInfant',
                                            fontSize: 37),
                                      )),
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
                                        fontFamily: 'YsabeauInfant',
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                  kIsWeb
                                      ? SizedBox(
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
                                          ))
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          child: AutoSizeText(
                                            movie.overview ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 20,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SegmentedButton<bool>(
                            selectedIcon: null,
                            emptySelectionAllowed: false,
                            showSelectedIcon: false,
                            selected: <bool>{isCastSelected},
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return primaryColor;
                                  }
                                  return Colors.white24;
                                },
                              ),
                            ),
                            segments: [
                              ButtonSegment<bool>(
                                label: Text(
                                  context.localizations.character_cast,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                value: true,
                              ),
                              ButtonSegment<bool>(
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
                            onSelectionChanged: (Set<bool> newSelection) {
                              setState(() {
                                isCastSelected = newSelection.first;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        isCastSelected
                            ? FilmCast(
                                movieId: AppConstants.mediaTypeId,
                                isCast: true,
                                mediaType: AppConstants.mediaType,
                              )
                            : FilmCast(
                                movieId: AppConstants.mediaTypeId,
                                isCast: false,
                                mediaType: AppConstants.mediaType,
                              )
                      ],
                    ),
                  )
                : YoutubePlayer(
                    controller: _trailerController,
                    enableFullScreenOnVerticalDrag: true,
                  );
          },
        ));
  }
}
