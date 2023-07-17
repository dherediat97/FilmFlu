import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';
import 'package:FilmFlu/ui/util/utilColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return FutureBuilder<Movie>(
        future: api.getMovie(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            var movie = snapshot.data;
            Color dominantColor = getImagePalette(CachedNetworkImageProvider(
                "$imgBaseUrl/${movie!.posterPath}")) as Color;
            print("movie=$movie");
            return Container(
              color: dominantColor,
              child: Column(
                children: [Text('Sinopsis'), Text(movie.overview!)],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
