//Core Packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/constants.dart';
import 'package:FilmFlu/ui/pages/movieDetails/movie_details.dart';
import 'package:FilmFlu/dto/movie_details_arguments.dart';

class MovieCarrouselItem extends StatelessWidget {
  const MovieCarrouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, MovieDetailsPage.routeName,
              arguments: MovieDetailsArguments(movie.id));
        },
        child: Container(
          width: 300,
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
    );
  }
}
