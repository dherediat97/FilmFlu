//Core Packages
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';

class FastMovieDetails extends StatefulWidget {
  const FastMovieDetails({super.key, required this.movieId});

  final int movieId;

  @override
  State<FastMovieDetails> createState() => _FastMovieDetailsState();
}

class _FastMovieDetailsState extends State<FastMovieDetails> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FutureBuilder<Movie>(
          future: api.fetchMovie(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movie = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 400,
                          child: Text(movie.title,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 30, fontFamily: "LilitaOne")),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/movieDetails/${movie.id}");
                            },
                            icon: Icon(Icons.info)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(AppLocalizations.of(context)!.synopsis,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(movie.overview!,
                        style: TextStyle(fontFamily: "Barlow"),
                        textAlign: TextAlign.justify),
                    SizedBox(height: 10),
                    Text(AppLocalizations.of(context)!.character_cast,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Barlow",
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    FilmCast(
                        cast: movie.credits!.cast!.sublist(0, 3), crew: []),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    ]);
  }
}
