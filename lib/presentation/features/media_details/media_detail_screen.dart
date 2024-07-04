import 'package:FilmFlu/app/constants/app_constants.dart';
import 'package:FilmFlu/app/constants/app_urls.dart';
import 'package:FilmFlu/app/extensions/custom_loading.dart';
import 'package:FilmFlu/app/extensions/localizations_extensions.dart';
import 'package:FilmFlu/domain/models/details_movie_arguments.dart';
import 'package:FilmFlu/domain/models/media_item_entity.dart';
import 'package:FilmFlu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:FilmFlu/presentation/features/media_details/widgets/media_cast_list.dart';
import 'package:FilmFlu/presentation/features/scaffold_page/custom_scaffold_page.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaItemScreenDetails extends StatefulWidget {
  const MediaItemScreenDetails({
    super.key,
    required this.movieArguments,
  });

  final DetailsMovieArguments movieArguments;

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
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitDown,
                      DeviceOrientation.portraitUp,
                    ]);
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
            DetailsMovieArguments movieArguments = widget.movieArguments;
            MediaItemEntity? movie = state.mediaItem;
            if (movie == null) {
              return Container();
            }

            String? movieTitle =
                movieArguments.mediaType == 'movie' ? movie.title : movie.name;

            return SingleChildScrollView(
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
                        loadingBuilder: (context, child, loadingProgress) =>
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
                              width: MediaQuery.of(context).size.width - 50,
                              child: AutoSizeText(
                                '$movieTitle',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'YsabeauInfant',
                                    fontSize: 37),
                              )),
                          // InkWell(
                          //   child: SvgPicture.asset(
                          //       height: 40,
                          //       width: 40,
                          //       "assets/icons/flags/${movie.originalLanguage}_flag.svg"),
                          //   onTap: () {
                          //     setState(() {
                          //       movieTitle = movie.originalTitle!;
                          //     });
                          //   },
                          // ),
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
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
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
            ));
          },
        )
        // :
        // FutureBuilder<VideoEntity>(
        //   future: Api().fetchTrailer(args.movieId, 'es_ES',
        //       args.mediaType == 'movie' ? 'movie' : 'tv'),
        //   builder: (context, snapshot) {
        //     haveTrailer = snapshot.hasData;
        //     if (snapshot.data != null) {
        //       _trailerController.loadVideoById(
        //           videoId: snapshot.data!.key);
        //     }
        //     SystemChrome.setPreferredOrientations([
        //       DeviceOrientation.landscapeRight,
        //       DeviceOrientation.landscapeLeft,
        //     ]);
        //     return YoutubePlayerScaffold(
        //         controller: _trailerController,
        //         builder: (context, player) {
        //           return Column(
        //             children: [
        //               Container(
        //                   height: MediaQuery.of(context).size.height,
        //                   padding: const EdgeInsets.only(top: 50),
        //                   child: player),
        //             ],
        //           );
        //         });
        //   },
        // ),
        );
  }
}
