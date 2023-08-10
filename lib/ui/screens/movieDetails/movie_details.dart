//Core Packages;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/client_api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';

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
  String youtubeVideoId = "";
  final _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
          showControls: false,
          showVideoAnnotations: false,
          strictRelatedVideos: true,
          loop: false,
          captionLanguage: "es",
          enableKeyboard: false,
          enableJavaScript: false,
          playsInline: true,
          interfaceLanguage: "es",
          pointerEvents: PointerEvents.none));

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
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                autofocus: true,
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
                                padding: const EdgeInsets.all(8),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              movie.title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'YsabeauInfant',
                                                  fontSize: 50),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(flex: 1),
                                      if (!widget.isTrailerSelected)
                                        FloatingActionButton(
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
                                            fontSize: 40,
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
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
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
              height: MediaQuery.of(context).size.height / 1.2,
              child: FutureBuilder<List<Video>>(
                future: Api().fetchTrailer(widget.movieId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    List videoList = snapshot.requireData;
                    if (videoList.firstOrNull != null) {
                      _controller.loadVideoById(videoId: videoList.first.key);
                      return YoutubePlayerScaffold(
                          controller: _controller,
                          builder: (context, player) {
                            return Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 50),
                                    child: player),
                              ],
                            );
                          });
                    } else {
                      return MovieDetailsPage(
                          movieId: widget.movieId, isTrailerSelected: false);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
    );
  }
}
