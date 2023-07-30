//Core Packages
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;
  static const routeName = '/movieDetails';

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isCastSelected = true;
  String youtubeVideoId = "";
  final _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
    showFullscreenButton: true,
    showControls: true,
    showVideoAnnotations: false,
    strictRelatedVideos: true,
    playsInline: false,
    captionLanguage: "es",
    interfaceLanguage: "es",
  ));

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      containerChild: FutureBuilder<Movie>(
          future: Api().fetchMovie(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              Movie movie = snapshot.requireData;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<List<Video>>(
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Video video = snapshot.requireData
                                  .where((video) =>
                                      video.type == "Trailer" && video.official)
                                  .first;

                              _controller.cueVideoById(videoId: video.key);
                              return YoutubePlayer(controller: _controller);
                            } else {
                              return Container();
                            }
                          },
                          future: Api().fetchTrailer(movie.id),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "$movieLandscapeBaseUrl${movie.backdropPath}",
                            ),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "YsabeauInfant",
                              fontSize: 60,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.synopsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "YsabeauInfant",
                              fontSize: 40,
                            ),
                          ),
                          Text(movie.overview!,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
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
                          }),
                    ),
                    isCastSelected
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: FilmCast(movieId: movie.id, isCast: true),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: FilmCast(movieId: movie.id, isCast: false),
                          )
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
