//Core Packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FutureBuilder<Movie>(
          future: api.fetchMovie(widget.movieId),
          builder: (context, snapshot) {
            // debugPrint(snapshot.toString());
            if (snapshot.hasData) {
              var movie = snapshot.data;
              if (movie != null) {
                // _controller.loadVideoById(videoId: movie.)
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(movie.title,
                          style:
                              TextStyle(fontSize: 28, fontFamily: "LilitaOne"),
                          textAlign: TextAlign.center),
                      Text(AppLocalizations.of(context)!.synopsis,
                          style: TextStyle(fontSize: 25, fontFamily: "Barlow")),
                      Text(
                        movie.overview!,
                        style: TextStyle(fontFamily: "Barlow"),
                        textAlign: TextAlign.justify,
                      ),

                      // Text("Tráiler",
                      //     style: TextStyle(fontSize: 30, fontFamily: "Barlow")),
                      // YoutubePlayer(
                      // controller: _controller,
                      // aspectRatio: 16 / 9,
                      // )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ]);
  }
}
