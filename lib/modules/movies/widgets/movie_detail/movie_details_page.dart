//Core Packages;
import 'package:FilmFlu/modules/movies/domain/entities/detailsMovieArguments.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/modules/shared/drivers/http/client_api.dart';
import 'package:FilmFlu/modules/shared/widgets/scaffold_page.dart';
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/modules/movies/widgets/movie_detail/movie_cast.dart';
import 'package:FilmFlu/core/extensions/loading_extension.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isCastSelected = true;
  bool isTrailerSelected = false;
  bool haveTrailer = false;
  late YoutubePlayerController _trailerController;

  @override
  void initState() {
    super.initState();
    initTrailerComponent();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsMovieArguments;

    return ScaffoldPage(
        isSearchVisible: true,
        isLightsOn: !isTrailerSelected,
        fabLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: isTrailerSelected
            ? FloatingActionButton(
                mini: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.stop),
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
                        initTrailerComponent();
                        setState(() {
                          isTrailerSelected = true;
                        });
                      },
                      child: Icon(Icons.play_arrow));
                },
              ),
        containerChild: !isTrailerSelected
            ? Container(
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder<MediaItem>(
                    future: Api().fetchMovie(args.movieId, args.mediaType),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return DefaultWidgetLoading();

                      MediaItem movie = snapshot.requireData;
                      String releaseYear = args.mediaType == "movie"
                          ? movie.releaseDate!.split("-")[0]
                          : movie.firstAirDate!.split("-")[0];
                      String? movieTitle =
                          args.mediaType == "movie" ? movie.title : movie.name;
                      return Column(
                        children: [
                          Container(
                            child: DecoratedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          child: AutoSizeText(
                                            "${movieTitle} (${releaseYear})",
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
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
                                  SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .synopsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "YsabeauInfant",
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
                                              movie.overview!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 20,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ]),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken,
                                  ),
                                  image: Image.network(
                                    "$movieLandscapeBaseUrl${movie.backdropPath}",
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            DefaultAsyncLoading(
                                      child: child,
                                      loadingProgress: loadingProgress,
                                    ),
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
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
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return primaryColor;
                                    }
                                    return Colors.white24;
                                  },
                                ),
                              ),
                              segments: [
                                ButtonSegment<bool>(
                                  label: Text(
                                    AppLocalizations.of(context)!
                                        .character_cast,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  value: true,
                                ),
                                ButtonSegment<bool>(
                                  label: Text(
                                    AppLocalizations.of(context)!
                                        .production_cast,
                                    style: TextStyle(
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
                          SizedBox(
                            height: 16,
                          ),
                          isCastSelected
                              ? FilmCast(
                                  movieId: args.movieId,
                                  isCast: true,
                                  mediaType: args.mediaType == "movie"
                                      ? "movie"
                                      : "tv")
                              : FilmCast(
                                  movieId: args.movieId,
                                  isCast: false,
                                  mediaType: args.mediaType == "movie"
                                      ? "movie"
                                      : "tv")
                        ],
                      );
                    },
                  ),
                ),
              )
            : FutureBuilder<Video>(
                future: Api().fetchTrailer(args.movieId, "es_ES",
                    args.mediaType == "movie" ? "movie" : "tv"),
                builder: (context, snapshot) {
                  haveTrailer = snapshot.hasData;
                  if (snapshot.data != null)
                    _trailerController.loadVideoById(
                        videoId: snapshot.data!.key);
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]);
                  return YoutubePlayerScaffold(
                      controller: _trailerController,
                      builder: (context, player) {
                        return Column(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height,
                                padding: EdgeInsets.only(top: 50),
                                child: player),
                          ],
                        );
                      });
                }));
  }

  initTrailerComponent() {
    _trailerController = YoutubePlayerController(
        params: YoutubePlayerParams(
      showControls: false,
      showVideoAnnotations: false,
      captionLanguage: "es",
      enableKeyboard: false,
      interfaceLanguage: "es",
    ));
  }
}
