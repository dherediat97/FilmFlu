//Core Packages;
import 'package:cached_network_image/cached_network_image.dart';
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
  bool isTrailerSelected = false;
  String youtubeVideoId = "";
  final _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
    showFullscreenButton: false,
    showControls: false,
    showVideoAnnotations: false,
    strictRelatedVideos: true,
    playsInline: true,
    loop: false,
    captionLanguage: "es",
    enableKeyboard: false,
    enableJavaScript: false,
    interfaceLanguage: "es",
    pointerEvents: PointerEvents.none,
  ));

  @override
  void initState() {
    super.initState();
    _controller.listen((event) {
      if (event.playerState == PlayerState.ended) {
        isTrailerSelected = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      isLightsOn: !isTrailerSelected,
      floatingActionButton: isTrailerSelected
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Icon(Icons.stop),
                onPressed: () {
                  isTrailerSelected = false;
                  setState(() {});
                },
              ),
            )
          : null,
      containerChild: !isTrailerSelected
          ? Container(
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
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 400,
                                            child: Text(
                                              movie.title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'YsabeauInfant',
                                                  fontSize: 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(flex: 1),
                                      FloatingActionButton(
                                          mini: true,
                                          onPressed: () {
                                            isTrailerSelected =
                                                !isTrailerSelected;
                                            setState(() {});
                                          },
                                          child: Icon(Icons.play_arrow)),
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
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 400,
                                          child: Text(
                                            movie.overview!,
                                            textAlign: TextAlign.justify,
                                            style:
                                                TextStyle(color: Colors.white),
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
                                    Colors.black.withOpacity(0.7),
                                    BlendMode.darken,
                                  ),
                                  image: CachedNetworkImageProvider(
                                    "$movieLandscapeBaseUrl${movie.backdropPath}",
                                  ),
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
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            )
          : Container(
              child: FutureBuilder<List<Video>>(
                future: Api().fetchTrailer(widget.movieId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Video> videoList = snapshot.requireData;
                    Video video = videoList.first;
                    _controller.loadVideoById(videoId: video.key);
                    return isTrailerSelected
                        ? OrientationBuilder(builder: (context, orientation) {
                            return AspectRatio(
                              aspectRatio: orientation == Orientation.landscape
                                  ? MediaQuery.of(context).size.aspectRatio
                                  : 16 / 9,
                              child: YoutubePlayer(controller: _controller),
                            );
                          })
                        : CircularProgressIndicator();
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
    );
  }
}
