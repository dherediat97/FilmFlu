//Core Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';
import 'package:FilmFlu/ui/components/movie_cast.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;
  static const routeName = '/movieDetails';

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "$movieLandscapeBaseUrl${movie.backdropPath}",
                          fit: BoxFit.contain,
                        ),
                        Positioned.fill(
                            child: Align(
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
                        )),
                        Text(
                          AppLocalizations.of(context)!.synopsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "YsabeauInfant",
                            fontSize: 40,
                          ),
                        ),
                        Text(movie.overview!),
                      ],
                    ),
                    Text(
                      AppLocalizations.of(context)!.character_cast,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "YsabeauInfant",
                        fontSize: 40,
                      ),
                    ),
                    FilmCast(movieId: movie.id, isCast: true),
                    Text(
                      AppLocalizations.of(context)!.production_cast,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    FilmCast(movieId: movie.id, isCast: false),
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
