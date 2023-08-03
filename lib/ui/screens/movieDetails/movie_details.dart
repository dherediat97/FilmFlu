//Core Packages
import 'package:FilmFlu/ui/components/movie_valoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;
  static const routeName = '/movieDetails';

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isCastSelected = true;
  bool isTrailerSelected = true;
  String youtubeVideoId = "";
  final _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
    showFullscreenButton: false,
    showControls: false,
    showVideoAnnotations: false,
    strictRelatedVideos: true,
    playsInline: true,
    loop: true,
    captionLanguage: "es",
    enableKeyboard: false,
    enableJavaScript: false,
    interfaceLanguage: "es",
    pointerEvents: PointerEvents.none,
  ));

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      containerChild: Container(
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: FutureBuilder<Movie>(
            future: Api().fetchMovie(widget.movieId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var movie = snapshot.requireData;
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: DecoratedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        movie.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "YsabeauInfant",
                                          fontSize: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      FloatingActionButton(
                                          onPressed: () {},
                                          child: Icon(Icons.play_arrow))
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.synopsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "YsabeauInfant",
                                          fontSize: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 600,
                                        child: Text(
                                          movie.overview!,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              Container(
                                child: FutureBuilder<List<Video>>(
                                  future: Api().fetchTrailer(movie.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Video> videoList =
                                          snapshot.requireData;
                                      Video video = videoList.firstWhere(
                                          (video) =>
                                              video.type == "Trailer" &&
                                              video.official,
                                          orElse: () => videoList.first);
                                      if (videoList.isNotEmpty)
                                        _controller.loadVideoById(
                                            videoId: video.key);
                                      return YoutubePlayer(
                                          controller: _controller);
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ]),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.dstOut,
                            ),
                            image: CachedNetworkImageProvider(
                                "$movieLandscapeBaseUrl${movie.backdropPath}"),
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
                        segments: [
                          ButtonSegment<bool>(
                            label: Text(
                              AppLocalizations.of(context)!.character_cast,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            value: true,
                          ),
                          ButtonSegment<bool>(
                            label: Text(
                              AppLocalizations.of(context)!.production_cast,
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
                    isCastSelected
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: FilmCast(
                              movieId: movie.id,
                              isCast: true,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: FilmCast(
                              movieId: movie.id,
                              isCast: false,
                            ),
                          )
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
