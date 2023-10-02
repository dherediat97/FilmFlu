//Core Packages;
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:auto_size_text/auto_size_text.dart';

//My Packages
import 'package:FilmFlu/dto/media_item.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/ui/theme/colors.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage(
      {super.key,
      required this.movieId,
      required this.isTrailerSelected,
      required this.isFilm});

  final bool isTrailerSelected;
  final int movieId;
  final bool isFilm;
  static const routeName = '/movieDetails';

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
    return ScaffoldPage(
        routeName: "",
        isSearchVisible: true,
        isLightsOn: !isTrailerSelected,
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
                    future: Api().fetchMovie(
                        widget.movieId, widget.isFilm ? "movie" : "tv"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        MediaItem movie = snapshot.requireData;
                        String releaseYear = widget.isFilm
                            ? movie.releaseDate!.split("-")[0]
                            : movie.firstAirDate!.split("-")[0];
                        String? movieTitle =
                            widget.isFilm ? movie.title : movie.name;
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
                                              "$movieTitle(${releaseYear})",
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
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: AutoSizeText(
                                            movie.overview!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 20,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
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
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
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
                                    movieId: movie.id,
                                    isCast: true,
                                    mediaType: widget.isFilm ? "movie" : "tv")
                                : FilmCast(
                                    movieId: movie.id,
                                    isCast: false,
                                    mediaType: widget.isFilm ? "movie" : "tv")
                          ],
                        );
                      } else {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ),
              )
            : FutureBuilder<Video>(
                future: Api().fetchTrailer(
                    widget.movieId, "es_ES", widget.isFilm ? "movie" : "tv"),
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
