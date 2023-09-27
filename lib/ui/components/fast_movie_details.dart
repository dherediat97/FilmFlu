//Core Packages
import 'package:FilmFlu/dto/base_arguments.dart';
import 'package:FilmFlu/ui/pages/movieDetails/movie_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/client_api.dart';

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
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(movie.title,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 22, fontFamily: "LilitaOne")),
                        ),
                        Spacer(flex: 1),
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, MovieDetailsPage.routeName,
                                  arguments: BaseArguments(movie.id, 0));
                            },
                            icon: Icon(Icons.info)),
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
