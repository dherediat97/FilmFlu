//Core Packages
import 'package:FilmFlu/dto/movie_details_arguments.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:FilmFlu/ui/screens/movieDetails/movie_details.dart';
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
    return Container(
      child: FutureBuilder<Movie>(
          future: api.fetchMovie(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movie = snapshot.requireData;
              return Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(movie.title,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 22, fontFamily: "LilitaOne")),
                        ),
                        Spacer(),
                        Tooltip(
                          message: "Más info aquí",
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, MovieDetailsPage.routeName,
                                    arguments: MovieDetailsArguments(movie.id));
                              },
                              icon: Icon(Icons.info)),
                        ),
                      ],
                    ),
                    Text(AppLocalizations.of(context)!.synopsis,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "YsabeauInfant",
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(movie.overview!,
                        style: TextStyle(fontFamily: "YsabeauInfant"),
                        textAlign: TextAlign.justify),
                    SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.character_cast,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "YsabeauInfant",
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    // FilmCast(movieId: movie.id, isCastComplete: false),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
          }),
    );
  }
}
