//Core Packages;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:auto_size_text/auto_size_text.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:FilmFlu/constants.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage(
      {super.key, required this.movieId, required this.isTrailerSelected});

  final bool isTrailerSelected;
  final int movieId;
  static const routeName = '/movieDetails';

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isCastSelected = true;
  bool isTrailerSelected = false;
  List<String> trailerVideosIds = [];
  late YoutubePlayerController _trailerController;

  @override
  void initState() {
    super.initState();
    trailerVideosIds.clear();
    initTrailerComponent();
    _trailerController.listen((event) {
      if (event.playerState == PlayerState.ended) {
        setState(() {
          isTrailerSelected = false;
        });
      }
    });
    fetchMovieTrailers("es-ES");
  }

  @override
  void dispose() {
    trailerVideosIds.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        isLightsOn: !isTrailerSelected,
        floatingActionButton: isTrailerSelected
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      _trailerController.stopVideo();
                      _trailerController.close();
                      isTrailerSelected = false;
                    });
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (trailerVideosIds.isNotEmpty) {
                        isTrailerSelected = true;
                        initTrailerComponent();
                        _trailerController.loadPlaylist(
                            list: trailerVideosIds,
                            listType: ListType.playlist);
                        setState(() {});
                      } else {
                        SnackBar snackBar = SnackBar(
                            content: Text("Esta película no tiene tráilers",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            duration: Duration(seconds: 2),
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Icon(Icons.play_arrow)),
              ),
        containerChild: !isTrailerSelected
            ? Container(
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder<Movie>(
                    future: Api().fetchMovie(widget.movieId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        Movie movie = snapshot.requireData;
                        String releaseYear = movie.releaseDate.split("-")[0];
                        String movieTitle = movie.title;
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: DecoratedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            child: AutoSizeText(
                                              "$movieTitle(${releaseYear})",
                                              minFontSize: 10,
                                              stepGranularity: 10,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'YsabeauInfant',
                                                  fontSize: 40),
                                            )),
                                        InkWell(
                                          child: SvgPicture.asset(
                                              height: 40,
                                              width: 40,
                                              "assets/icons/${movie.originalLanguage}_flag.svg"),
                                          onTap: () {
                                            setState(() {
                                              movieTitle = movie.originalTitle!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 100),
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
                                          child: SizedBox(
                                            width: 400,
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
                                      fit: BoxFit.fill,
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
                              height: 60,
                            ),
                            Center(
                              child: SegmentedButton<bool>(
                                selectedIcon: null,
                                emptySelectionAllowed: false,
                                showSelectedIcon: false,
                                selected: <bool>{isCastSelected},
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
                                ? FilmCast(movieId: movie.id, isCast: true)
                                : FilmCast(movieId: movie.id, isCast: false)
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
            : FutureBuilder<List<String>>(
                future: fetchMovieTrailers("es-ES"),
                builder: (context, snapshot) {
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

  fetchMovieTrailers(String language) {
    Api().fetchTrailers(widget.movieId, language).then((trailerList) {
      if (trailerList.isNotEmpty) {
        trailerVideosIds = trailerList.map((e) => e.key).toList();
      } else {
        fetchMovieTrailers("");
      }
    });
  }
}
