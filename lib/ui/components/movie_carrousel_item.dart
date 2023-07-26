import 'package:FilmFlu/ui/components/fast_movie_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FilmFlu/dto/movie.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/network/api.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              isDismissible: true,
              context: context,
              builder: (context) => FastMovieDetails(movieId: movie.id));
        },
        child: Card(
          margin: EdgeInsets.all(0),
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      '$movieImgBaseURL${movie.posterPath}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
